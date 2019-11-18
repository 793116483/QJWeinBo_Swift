//
//  QJHomeTableViewCell.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/12.
//  Copyright © 2019 yiniu. All rights reserved.
//  home cell

import UIKit

private let kGrayColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)

class QJHomeTableViewCell: UITableViewCell {
    // MARK: 属性
    /// 用户头象
    
    private var iconImageView:UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar_default_small"))
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
       return imageView
    }()
    /// 用户认证
    private var verifiedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    /// 用户名
    private var userNameLabel: UILabel =  {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 15)
        name.textColor = UIColor.black
        return name
    }()
    /// 用户是否是Vip
    private var vipImageView: UIImageView = UIImageView()
    /// 发微博的时间
    private var createdTimeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = UIColor.lightGray
        return timeLabel
    }()
    /// 微博来源
    private var sourceLabel: UILabel = {
        let sourceLabel = UILabel()
        sourceLabel.font = UIFont.systemFont(ofSize: 12)
        sourceLabel.textColor = UIColor.lightGray
        return sourceLabel
    }()
    /// 正文内容
    private var contentTextLabel: HYLabel = {
        let contentLabel = HYLabel()
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: 18)
        contentLabel.textColor = UIColor.black
        return contentLabel
    }()
    /// 转发微博 view
    private var retweetSatuseView = QJHomeCellRetweetSatuseView()
    /// 图片展示
    lazy private var pictrueView:QJPictureCollectionView = {
        let maxWith = UIScreen.main.bounds.width - QJHomeTableViewCell.space * 2
        return QJPictureCollectionView.pictureCollectionView(maxWidth: maxWith)
    }()
    /// 底部 views
    private var bottomView: QJHomeCellBottomView = {
        let bottomView = Bundle.main.loadNibNamed("QJHomeCellBottomView", owner: nil, options: nil)?.first as? QJHomeCellBottomView
        return bottomView!
    }()
    /// 一条微博数据
    var statuse:QJStatuseModel? {
        didSet{
            setUIData()
            // 设置完数据后就计算高度
            cellHeight = calculateCellHeight()
        }
    }
    /// 用于布局的 间隔
    static var space:CGFloat {
        return 15
    }
    /// cell高度
    var cellHeight:CGFloat = 0
    
    // MARK: 方法
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let bgView = UIView()
        bgView.backgroundColor = kGrayColor
        self.selectedBackgroundView = bgView
        
        addSubviewsToContentView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 创建 cell
    class func cell(with tableView:UITableView , statuse:QJStatuseModel) -> QJHomeTableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "QJHomeTableViewCell") as? QJHomeTableViewCell
        if cell == nil {
            cell = QJHomeTableViewCell(style: .default, reuseIdentifier: "QJHomeTableViewCell")
            
            Log(cell)
        }
        
        // 设置数据
        cell?.statuse = statuse

        return cell!
    }
}

// MARK: 设置UI
private extension QJHomeTableViewCell {
    /// 添加 cell 内的 子控件
    func addSubviewsToContentView() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(verifiedImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(vipImageView)
        contentView.addSubview(createdTimeLabel)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(contentTextLabel)
        contentView.addSubview(retweetSatuseView)
        contentView.addSubview(pictrueView)
        contentView.addSubview(bottomView)
        
        iconImageView.mas_makeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.contentView)?.offset()(QJHomeTableViewCell.space)
            make?.top.equalTo()(self?.contentView)?.offset()(QJHomeTableViewCell.space)
            make?.width.equalTo()(40)
            make?.height.equalTo()(40)
        }
        verifiedImageView.mas_makeConstraints {[weak self] (make) in
            make?.right.equalTo()(self?.iconImageView)
            make?.bottom.equalTo()(self?.iconImageView)
        }
        userNameLabel.mas_makeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.iconImageView.mas_right)?.offset()(QJHomeTableViewCell.space)
            make?.top.equalTo()(self?.iconImageView)
        }
        vipImageView.mas_makeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.userNameLabel.mas_right)?.offset()(QJHomeTableViewCell.space)
            make?.centerY.equalTo()(self?.userNameLabel)
        }
        createdTimeLabel.mas_makeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.iconImageView.mas_right)?.offset()(QJHomeTableViewCell.space)
            make?.bottom.equalTo()(self?.iconImageView)
        }
        sourceLabel.mas_makeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.createdTimeLabel.mas_right)?.offset()(QJHomeTableViewCell.space)
            make?.bottom.equalTo()(self?.createdTimeLabel)
        }
        contentTextLabel.mas_makeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.contentView)?.offset()(QJHomeTableViewCell.space)
            make?.right.equalTo()(self?.contentView)?.offset()(-QJHomeTableViewCell.space)
            make?.top.equalTo()(self?.iconImageView.mas_bottom)?.offset()(QJHomeTableViewCell.space)
        }
        retweetSatuseView.mas_remakeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.contentView)
            make?.right.equalTo()(self?.contentView)
            make?.top.equalTo()(self?.contentTextLabel.mas_bottom)?.offset()(0)
            make?.height.equalTo()(0)
        }
        pictrueView.mas_remakeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.contentView)?.offset()(QJHomeTableViewCell.space)
            make?.top.equalTo()(self?.retweetSatuseView.mas_bottom)?.offset()(0)
            make?.size.equalTo()(CGSize.zero)
        }
        bottomView.mas_makeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.contentView)
            make?.right.equalTo()(self?.contentView)
            make?.bottom.equalTo()(self?.contentView)
            make?.height.equalTo()(55)
        }
    }
    
    /// 设置子控件数据
    func setUIData() {
        iconImageView.sd_setImage(with: URL(string: statuse?.user?.profile_image_url ?? ""), completed: nil)
        verifiedImageView.image = statuse?.user?.verifiedImage
        vipImageView.image = statuse?.user?.vipImage
        userNameLabel.text = statuse?.user?.screen_name
        userNameLabel.textColor = vipImageView.image != nil ? .orange : .black
        createdTimeLabel.text = statuse?.created_at_show
        sourceLabel.text = statuse?.source
        contentTextLabel.text = statuse?.text
        retweetSatuseView.statuse = statuse?.retweeted_status
        pictrueView.pictureUrls = statuse?.pic_URLs
        bottomView.setUIData(statuse: statuse)
        
        // 重新设置 retweetSatuseView 布局
        let retweetSatuseViewSpace = retweetSatuseView.selfHeight > 0 ? QJHomeTableViewCell.space : 0
        retweetSatuseView.mas_remakeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.contentView)
            make?.right.equalTo()(self?.contentView)
            make?.top.equalTo()(self?.contentTextLabel.mas_bottom)?.offset()(retweetSatuseViewSpace)
            make?.height.equalTo()(self?.retweetSatuseView.selfHeight)
        }
        // 重新设置 pictrueView 布局
        let pictrueViewSize = pictrueView.collectionViewSize()
        let pictrueViewSpace = pictrueViewSize.height > 0 ? QJHomeTableViewCell.space : 0
        pictrueView.mas_remakeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.contentView)?.offset()(QJHomeTableViewCell.space)
            make?.top.equalTo()(self?.retweetSatuseView.mas_bottom)?.offset()(pictrueViewSpace)
            make?.size.equalTo()(pictrueViewSize)
        }
    }
    
}

// MARK: 工具方法
extension QJHomeTableViewCell {
    func calculateCellHeight() -> CGFloat {
        // 间隔
        let space = QJHomeTableViewCell.space
        // 头象高度
        let iconH:CGFloat = space + 40
        // 正文高度
        var textH = ((statuse?.text ?? "") as NSString).size(maxWidth: pictrueView.maxWidth, textFont:contentTextLabel.font).height
        textH += (textH > 0 ? space : 0)
        // 转发微博的高度
        var retweetSatuseViewH = retweetSatuseView.selfHeight
        retweetSatuseViewH += retweetSatuseViewH > 0 ? space : 0
        // 配图高度
        var pictrueViewH = pictrueView.collectionViewSize().height
        pictrueViewH += (pictrueViewH > 0 ? space : 0)
        // 底部 view 高度
        var bottomH:CGFloat = 55
        bottomH += retweetSatuseViewH > 0 ? 0 : space
        
        return iconH + textH + retweetSatuseViewH + pictrueViewH + bottomH
    }
}

// MARK: 转发微博的view
class QJHomeCellRetweetSatuseView : UIView {
    /// 显示的内容：@用户名+正文
    private var textLabel:HYLabel = {
        let label = HYLabel()
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    /// 图片展示
    lazy private var pictrueView:QJPictureCollectionView = QJPictureCollectionView.pictureCollectionView(maxWidth: UIScreen.main.bounds.width - QJHomeTableViewCell.space * 2)
    
    /// 被转发的微博
    var statuse:QJStatuseModel? {
        didSet{
            setUIData()
            selfHeight = calculateSelfHeight()
        }
    }
    /// 自身的高度，前提必须先设置转发微博的数据
    var selfHeight:CGFloat = 0
    
    // 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = kGrayColor
        
        
        self.addSubview(textLabel)
        self.addSubview(pictrueView)
        
        textLabel.mas_remakeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.mas_left)?.offset()(QJHomeTableViewCell.space)
            make?.right.equalTo()(self?.mas_right)?.offset()(-QJHomeTableViewCell.space)
            make?.top.equalTo()(self?.mas_top)?.offset()(QJHomeTableViewCell.space)
        }
        pictrueView.mas_remakeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.mas_left)?.offset()(QJHomeTableViewCell.space)
            make?.top.equalTo()(self?.textLabel.mas_bottom)?.offset()(0)
            make?.size.equalTo()(CGSize.zero)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置UI数据
    func setUIData(){
        guard let statuse = statuse else {
            textLabel.text = nil
            pictrueView.mas_remakeConstraints {[weak self] (make) in
                make?.left.equalTo()(self?.mas_left)?.offset()(QJHomeTableViewCell.space)
                make?.top.equalTo()(self?.textLabel.mas_bottom)?.offset()(0)
                make?.size.equalTo()(CGSize.zero)
            }
            return
        }
        
        // 设置转发内容
        textLabel.text = "@\(statuse.user?.screen_name ?? ""):\(statuse.text ?? "")"
        
        // 设置配图数据
        pictrueView.pictureUrls = statuse.pic_URLs
        // 重新布局配图 view
        let pictrueViewSize = pictrueView.collectionViewSize()
        let pictrueViewSpace = pictrueViewSize.height > 0 ? QJHomeTableViewCell.space : 0
        pictrueView.mas_remakeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.mas_left)?.offset()(QJHomeTableViewCell.space)
            make?.top.equalTo()(self?.textLabel.mas_bottom)?.offset()(pictrueViewSpace)
            make?.size.equalTo()(pictrueViewSize)
        }
    }
    /// 计算自身高度
    func calculateSelfHeight() -> CGFloat {
        
        guard let statuse = statuse else {
            return 0
        }
        
        // 间隔
        let space = QJHomeTableViewCell.space

        // 正文高度
        var textH = ((statuse.text ?? "") as NSString).size(maxWidth: pictrueView.maxWidth, textFont:textLabel.font).height
        textH += (textH > 0 ? space : 0)
        // 配图高度
        var pictrueViewH = pictrueView.collectionViewSize().height
        pictrueViewH += (pictrueViewH > 0 ? space : 0)
        
        return textH + pictrueViewH + ((textH + pictrueViewH) > 0 ? space : 0)
    }
}

// MARK: QJHomeCellBottomView
class QJHomeCellBottomView: UIView {
    @IBOutlet weak var repostsBtn: UIButton!
    @IBOutlet weak var commentsBtn: UIButton!
    @IBOutlet weak var attitudesBtn: UIButton!
    
    func setUIData(statuse:QJStatuseModel?) {
        guard let statuse = statuse  else {
            return
        }
        
        let repostsText = statuse.reposts_count == 0 ? "转发":"转发(\(statuse.reposts_count))"
        let commentsText = statuse.comments_count == 0 ? "评论":"评论(\(statuse.comments_count))"
        let attitudesText = statuse.attitudes_count == 0 ? "点赞":"点赞(\(statuse.attitudes_count))"
        repostsBtn.setTitle(repostsText, for: .normal)
        commentsBtn.setTitle(commentsText, for: .normal)
        attitudesBtn.setTitle(attitudesText, for: .normal)
    }
}
