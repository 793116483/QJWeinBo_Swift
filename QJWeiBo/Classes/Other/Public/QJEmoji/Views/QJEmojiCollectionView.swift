//
//  QJEmojiCollectionView.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/19.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJEmojiCollectionView: UIView {

    let collectionView:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: QJCollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
//        collectionView.isPagingEnabled = true
//        (collectionView.collectionViewLayout as! QJCollectionViewFlowLayout).scrollDirection = .horizontal
        collectionView.register(QJEmojiCollectionViewCell.self, forCellWithReuseIdentifier: "QJEmojiCollectionViewCell")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.collectionView.frame = self.bounds
        let layout = self.collectionView.collectionViewLayout as? QJCollectionViewFlowLayout
        let itemWH = collectionView.width / 8
        layout?.itemSize = CGSize(width: itemWH, height: itemWH)
        
    }
}

// MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension QJEmojiCollectionView : UICollectionViewDataSource , UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return QJEmojiGroupManagerModel.manager.groupModes.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return QJEmojiGroupManagerModel.manager.groupModes[section].emojiModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QJEmojiCollectionViewCell", for: indexPath) as? QJEmojiCollectionViewCell
        if cell == nil {
            cell = QJEmojiCollectionViewCell()
        }
        cell?.model = QJEmojiGroupManagerModel.manager.groupModes[indexPath.section].emojiModels[indexPath.row]
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = QJEmojiGroupManagerModel.manager.groupModes[indexPath.section].emojiModels[indexPath.row]
        Log(item.chs , item.png , item.code)
    }
    
}


// MARK: 自定义 CollectionViewCell
class QJEmojiCollectionViewCell: UICollectionViewCell {
    /// 模型数据
    var model:QJEmojiModel? {
        didSet{
            self.imageView.image = UIImage(contentsOfFile: model?.png ?? "")
            self.textLabel.text = model?.code
            
            Log(model?.code ,self.imageView.image , model?.png)
            
        }
    }
    
    private let imageView:UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    private let textLabel:UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32)
        label.textAlignment = .center
        label.backgroundColor = .clear
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(textLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView.sizeToFit()
        self.imageView.center = CGPoint(x: self.width/2, y: self.height/2)
        self.textLabel.frame = self.bounds
    }
}


class QJCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
}
