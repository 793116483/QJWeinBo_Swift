//
//  QJPictureCollectionView.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/14.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJPictureCollectionView: UICollectionView {
    /// 每个 item 间隔
    private let itemSpacing:CGFloat = 5
    var maxWidth : CGFloat = 0
    var pictureUrls : [NSURL]? {
        didSet{
            // 重新改变 layout
            let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = itemSize()
            layout.minimumLineSpacing = itemSpacing
            layout.minimumInteritemSpacing = itemSpacing
            self.collectionViewLayout = layout
            
            self.reloadData()
        }
    }
    
    class func pictureCollectionView(maxWidth : CGFloat) -> QJPictureCollectionView{

        
        // 流布局
        let layout = UICollectionViewFlowLayout()
        // 创建 collectionView
        let pictureView = QJPictureCollectionView(frame: CGRect() , collectionViewLayout: layout) 
        pictureView.backgroundColor = .clear
        pictureView.dataSource = pictureView
        pictureView.delegate = pictureView
        pictureView.maxWidth = maxWidth
        // 注册
        pictureView.register(QJPictureCollectionViewCell.self, forCellWithReuseIdentifier: "QJPictureCollectionViewCell")
        
        return pictureView
    }
}
// MARK: 计算
extension QJPictureCollectionView {
    
    func itemSize() -> CGSize {
        guard let urls = pictureUrls else {
            return CGSize(width: 0, height: 0)
        }
        guard urls.count > 0 else {
            return CGSize(width: 0, height: 0)
        }
        // 一行最多方 3 个
        let itemWH:CGFloat = (maxWidth - itemSpacing * 2) / 3
        
        return CGSize(width: itemWH, height: itemWH)
    }
    
    func collectionViewSize() -> CGSize{
        
        guard let urls = pictureUrls else {
            return CGSize(width: 0, height: 0)
        }
        guard urls.count > 0 else {
            return CGSize(width: 0, height: 0)
        }
        
        let itemSize = self.itemSize()
        // 如果只有4个
        if urls.count == 4 {
            return CGSize(width: itemSize.width * 2 + itemSpacing , height: itemSize.height * 2 + itemSpacing)
        }
        
        // 行数
        let row:CGFloat = CGFloat((urls.count - 1) / 3) + 1
        let colum:CGFloat = urls.count > 3 ? 3:CGFloat(urls.count)
        
        return CGSize(width: itemSize.width * colum + itemSpacing*(colum - 1) , height: itemSize.height * row + itemSpacing*(row - 1))
    }
    
}

// MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension QJPictureCollectionView : UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return pictureUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QJPictureCollectionViewCell", for: indexPath) as? QJPictureCollectionViewCell
        if cell == nil {
            cell = QJPictureCollectionViewCell()
        }
        cell?.imageURL = self.pictureUrls?[indexPath.row]
        return cell!
    }
}


// MARK: QJCollectionViewCell
class QJPictureCollectionViewCell: UICollectionViewCell {
    
    var iconView:UIImageView = {
        let imageView = UIImageView()
//        imageView.contentMode = .top
        imageView.clipsToBounds = true
        
        return imageView
    }()
    var imageURL:NSURL? {
        didSet{
            self.iconView.sd_setImage(with: imageURL as? URL, placeholderImage: UIImage(named: "empty_picture"), options: []) {[] (image, error, type, url) in

                if image === nil {
                    self.iconView.image = UIImage(named: "empty_picture")
                }
                else{
                    self.iconView.image = image
                }
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(iconView)
        iconView.mas_remakeConstraints {[weak self] (make) in
            make?.left.equalTo()(self?.contentView)
            make?.top.equalTo()(self?.contentView)
            make?.bottom.equalTo()(self?.contentView)
            make?.right.equalTo()(self?.contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

