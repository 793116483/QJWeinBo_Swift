//
//  QJTextView.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/16.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJTextView: UITextView {

    let placeHolderLable:UILabel = {
        let lable = UILabel()
        lable.textColor = UIColor.lightGray
        lable.font = UIFont.systemFont(ofSize: 16)
        lable.backgroundColor = .clear
        return lable
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.addSubview(placeHolderLable)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.placeHolderLable.sizeToFit()
        self.placeHolderLable.frame = CGRect(x: 8, y: 0, width: placeHolderLable.width , height: self.placeHolderLable.height)
        self.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 8)
    }
}
