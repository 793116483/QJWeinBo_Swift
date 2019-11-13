//
//  QJHomeTableViewCell.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/12.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

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


class QJHomeTableViewCell: UITableViewCell {
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
    private var contentTextLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: 18)
        contentLabel.textColor = UIColor.black
        return contentLabel
    }()
    /// 底部 views
    private var bottomView: QJHomeCellBottomView = {
        let bottomView = Bundle.main.loadNibNamed("HomeCellBottomView", owner: nil, options: nil)?.first as? QJHomeCellBottomView
        return bottomView!
    }()
    
    /// 一条微博数据
    var statuse:QJStatuseModel? {
        didSet{
            cellHeight = calculateCellHeight()
        }
    }
    
    /// 用于布局的 间隔
    private let space:CGFloat = 15
    /// cell高度
    var cellHeight:CGFloat = 0
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
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
        cell?.setUIData()

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
        contentView.addSubview(bottomView)
        
        iconImageView.mas_makeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.contentView)?.offset()(space)
            make?.top.equalTo()(self?.contentView)?.offset()(space)
            make?.width.equalTo()(40)
            make?.height.equalTo()(40)
        }
        verifiedImageView.mas_makeConstraints {[weak self] (make) in
            make?.right.equalTo()(self?.iconImageView)
            make?.bottom.equalTo()(self?.iconImageView)
        }
        userNameLabel.mas_makeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.iconImageView.mas_right)?.offset()(space)
            make?.top.equalTo()(self?.iconImageView)
        }
        vipImageView.mas_makeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.userNameLabel.mas_right)?.offset()(space)
            make?.centerY.equalTo()(self?.userNameLabel)
        }
        createdTimeLabel.mas_makeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.iconImageView.mas_right)?.offset()(space)
            make?.bottom.equalTo()(self?.iconImageView)
        }
        sourceLabel.mas_makeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.createdTimeLabel.mas_right)?.offset()(space)
            make?.bottom.equalTo()(self?.createdTimeLabel)
        }
        contentTextLabel.mas_makeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.contentView)?.offset()(space)
            make?.right.equalTo()(self?.contentView)?.offset()(-space)
            make?.top.equalTo()(self?.iconImageView.mas_bottom)?.offset()(space)
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
        userNameLabel.text = statuse?.user?.screen_name
        vipImageView.image = statuse?.user?.vipImage
        createdTimeLabel.text = statuse?.created_at_show
        sourceLabel.text = statuse?.source
        contentTextLabel.text = statuse?.text
        bottomView.setUIData(statuse: statuse)
        
        userNameLabel.textColor = vipImageView.image != nil ? .orange : .black
    }
    
}

// MARK: 工具方法
extension QJHomeTableViewCell {
    func calculateCellHeight() -> CGFloat {
        let iconMaxY:CGFloat = space + 40
        let maxWidth:CGFloat = UIScreen.main.bounds.width - space * 2
        let textSize = ((statuse?.text ?? "") as NSString).size(maxWidth: maxWidth, textFont:contentTextLabel.font)
        
        return iconMaxY + space + textSize.height + space + 55
    }
}
