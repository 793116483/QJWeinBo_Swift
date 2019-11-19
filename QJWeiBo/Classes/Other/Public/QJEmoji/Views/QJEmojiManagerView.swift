//
//  QJEmojiManagerView.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/19.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJEmojiManagerView: UIView {

    private let emojiCollectionView = QJEmojiCollectionView()
    private let toolBarView = QJToolBarView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(emojiCollectionView)
//        addSubview(toolBarView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        toolBarView.frame = CGRect(x: 0, y: self.height - 40, width: self.width, height: 0)
        emojiCollectionView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height-toolBarView.height)
    }
}
