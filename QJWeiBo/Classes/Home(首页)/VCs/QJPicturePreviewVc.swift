//
//  QJPicturePreviewVc.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/20.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit
import SVProgressHUD

class QJPhotoPreviewVc: QJBaseViewController {

    // MARK: 属性
    var pictureUrls:[NSURL]?
    var indexPath:NSIndexPath?
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: QJPhotoPreviewCollectionViewFlowLayout())
    private let saveButton = QJButton()
    private let closeButton = QJButton()

    // MARK: 方法
    init(pictureUrls:[NSURL]? , indexPath:NSIndexPath?){
        self.pictureUrls = pictureUrls
        self.indexPath = indexPath
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if indexPath != nil {
            // 滑动到对应的 index 位置
            collectionView.scrollToItem(at: indexPath! as IndexPath, at: .left, animated: false)
            indexPath = nil
        }
    }
}


// MARK: UI设置
private extension QJPhotoPreviewVc {
    func setUpUI() {
        view.addSubview(collectionView)
        view.addSubview(closeButton)
        view.addSubview(saveButton)
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.contentSize = CGSize(width: self.view.width + QJPhotoPreviewCell.space, height: self.view.height)
        collectionView.reloadData()
        collectionView.mas_makeConstraints { (make) in
            make?.left.equalTo()
            make?.right.equalTo()(QJPhotoPreviewCell.space)
            make?.top.equalTo()
            make?.bottom.equalTo()
        }
        
        closeButton.setTitle("关 闭", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.titleLabel?.font = .systemFont(ofSize: 14)
        closeButton.backgroundColor = .gray
        closeButton.layer.cornerRadius = 4
        closeButton.layer.masksToBounds = true
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        closeButton.mas_makeConstraints {(make) in
            make?.left.equalTo()(20)
            make?.bottom.equalTo()(-30)
            make?.size.equalTo()(CGSize(width: 90, height: 32))
        }
        
        saveButton.setTitle("保 存", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 14)
        saveButton.backgroundColor = .gray
        saveButton.layer.cornerRadius = 4
        saveButton.layer.masksToBounds = true
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        saveButton.mas_makeConstraints {(make) in
            make?.right.equalTo()(-20)
            make?.bottom.equalTo()(-30)
            make?.size.equalTo()(CGSize(width: 90, height: 32))
        }
    }
}


// MARK: 点击事件
private extension QJPhotoPreviewVc {
    /// 关闭事件
    @objc func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }
    /// 保存事件
    @objc func saveAction() {
        let cell = self.collectionView.visibleCells.first as? QJPhotoPreviewCell
        guard let image =  cell?.imageView.image else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(savedToPhotosAlbum(_:didFinishSaving:contextInfo:)), nil)
    }
    // 必须接收这三个参数,因为是系统传的
    @objc func savedToPhotosAlbum(_ image:UIImage , didFinishSaving error:NSError? , contextInfo:Any){
        Log(image  )
        if error == nil {
            SVProgressHUD.showSuccess(withStatus: "保存成功")
        } else {
            SVProgressHUD.showError(withStatus: "保存失败")
        }
    }
}
 

// MARK: UICollectionViewDataSource
extension QJPhotoPreviewVc : UICollectionViewDataSource , QJPhotoPreviewCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QJPhotoPreviewCell", for: indexPath)  as! QJPhotoPreviewCell
        cell.pictureUrl = pictureUrls?[indexPath.row];
        cell.delegate = self
        
        return cell
    }
    
    // QJPhotoPreviewCell Delegate
    func cellDidClicked(cell: QJPhotoPreviewCell) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: ----------------------------------------------------
// MARK: 自定义 流布局
class QJPhotoPreviewCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        // 设置流布局
        itemSize = collectionView!.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        
        // 设置 collectionView
        collectionView?.register(QJPhotoPreviewCell.self, forCellWithReuseIdentifier: "QJPhotoPreviewCell")
        collectionView?.isPagingEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
    }
}

// MARK: ----------------------------------------------------
// MARK: 自定义 PhotoPreview CollectionView cell
import SDWebImage
class QJPhotoPreviewCell: UICollectionViewCell {
    
    /// 图片 URL
    var pictureUrl:NSURL? {
        didSet{
            dealSetPictureUrl(smallURL: pictureUrl)
        }
    }
    weak var delegate:QJPhotoPreviewCellDelegate?
    
    private let scrollView = UIScrollView()
    let imageView = QJImageView(frame: CGRect.zero)
    private let progressView = QJProgressView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: 设置 UI
private extension QJPhotoPreviewCell {
    func setUI() {
        // 添加控件
        contentView.addSubview(scrollView)
        scrollView.backgroundColor = .clear

        scrollView.addSubview(imageView)
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.maximumZoomScale = 2.5
        imageView.minimumZoomScale = 1.0
        // 添加点击事件
        // 一次点击事件
        let tapOneGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(tapGesture:)))
        tapOneGesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(tapOneGesture)
        // 两次点击事件
        let tapTwoGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(tapGesture:)))
        tapTwoGesture.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tapTwoGesture)
        // 添加优先级
        tapOneGesture.require(toFail: tapTwoGesture);

        
        contentView.addSubview(progressView)
        progressView.backgroundColor = .clear
        progressView.isHidden = true
    }
    
    /// 间隔
    static let space:CGFloat = 15
    
    func dealSetPictureUrl(smallURL:NSURL?) {
        guard let smallURL = smallURL else {
            return
        }
        let cacheKey = SDWebImageManager.shared.cacheKey(for: smallURL as URL)
        let image = SDImageCache.shared.imageFromDiskCache(forKey: cacheKey)
        let imageScale = (image?.size.height ?? 0) / (image?.size.width ?? 1)
        
        let width = self.width - QJPhotoPreviewCell.space
        let height = width * imageScale
        var y = (self.height - height) * 0.5
        y = y>0 ? y : 0
        imageView.frame = CGRect(x:0 , y: y , width: width , height: height)
        // 下载大图片
        progressView.progress = 0
        progressView.isHidden = false
        imageView.sd_setImage(with: getBigURL(smallURL: smallURL), placeholderImage: image, options: [], progress: {[weak self] (current, totle, _) in
            self?.progressView.progress = CGFloat(current) / CGFloat(totle)
        }){[weak self] (_, _, _, _) in
            self?.progressView.isHidden = true
        }
        // image 可滑动的范围
        scrollView.contentSize = imageView.size
    }
    /// 获取微博对应中等配图
    func getBigURL(smallURL:NSURL) -> URL? {
        guard let urlString = smallURL.absoluteString else {
            return nil
        }
        let bigUrlStr = (urlString as NSString).replacingOccurrences(of: "thumbnail", with: "bmiddle")
        return URL(string: bigUrlStr)
    }
    
    override internal func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.frame = bounds
        progressView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        progressView.center = scrollView.center
    }
    
}

// MARK: 图片缩放 功能
extension QJPhotoPreviewCell  {
    @objc func tapAction(tapGesture:UITapGestureRecognizer) {
        if tapGesture.numberOfTapsRequired == 1 {
            Log("点击了一次")
            delegate?.cellDidClicked(cell: self)
        } else {
            
            if (self.imageView.zoomScale != 1.0) {
//                imageView.origin = CGPoint(x: imageView.origin.x - scrollView.contentOffset.x , y: imageView.origin.y - scrollView.contentOffset.y)
//                scrollView.contentOffset = CGPoint.zero
                imageView.zoom(scale: 1.0, zoomCenter: tapGesture.location(in: tapGesture.view!))
//                scrollView.contentSize = imageView.size
            } else {
                Log(NSValue(cgRect: imageView.frame))
                let startOrigin = imageView.frame.origin
                
                imageView.zoom(scale:2.5 , zoomCenter:tapGesture.location(in : tapGesture.view!));
//                scrollView.contentSize = imageView.size
//                let offset = CGPoint(x: startOrigin.x - imageView.origin.x , y: startOrigin.y - imageView.origin.y)
//                imageView.origin = startOrigin
//                scrollView.contentOffset = offset
//                Log(NSValue(cgRect: imageView.frame))

            }
            
            Log("点击了多次")
        }
    }
}

// MARK: cell 代理协议
@objc protocol QJPhotoPreviewCellDelegate {
    @objc func cellDidClicked(cell:QJPhotoPreviewCell)
}

// MARK: 自定义下载进度显示 view
class QJProgressView: UIView {
    
    var progress:CGFloat = 0 {
        didSet{
            DispatchQueue.main.async {
                self.setNeedsDisplay()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        UIColor.gray.set()
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
        let radius = rect.width * 0.5 - 4
        let ovalPath = UIBezierPath(arcCenter: center , radius: radius , startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
        ovalPath.lineWidth = 4
        ovalPath.stroke()
        
        UIColor.orange.set()
        let startAngle = -CGFloat(M_PI_2)
        let endAngle = startAngle + CGFloat(M_PI*2)*progress
        let arcPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle , endAngle: endAngle , clockwise: true)
        arcPath.lineWidth = 4
        arcPath.stroke()
    }
}
