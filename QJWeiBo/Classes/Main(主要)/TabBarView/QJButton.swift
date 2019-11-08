//
//  QJButton.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/7.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJButton: UIButton {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    // MARK: 布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var titleH:CGFloat = 0
        if self.titleLabel?.text?.isEmpty == false {
            titleH = 14
        }
        let space:CGFloat = 2
        self.imageView?.frame = CGRect(x: 0, y: space, width: self.width, height: self.height - 3*space - titleH)
        self.titleLabel?.frame = CGRect(x: 0, y: self.imageView!.height+space, width: self.width, height: titleH)
    }
}


extension QJButton {
    
    /// 设置文字 与 图片
    func set(title:String? , image imageName:String , selectImage selectImageName:String){
        
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .selected)
        self.setImage(UIImage(named: imageName), for: .normal)
        self.setImage(UIImage(named: selectImageName), for: .selected)
        self.setImage(UIImage(named: selectImageName), for: .highlighted)
    }
    /// 设置文字的字体大小与颜色
    func set(titleFont:UIFont = UIFont.systemFont(ofSize: 14) , titleColor:UIColor = UIColor.gray , selectedTitleColor:UIColor = UIColor.orange) {
        self.setTitleColor(titleColor, for: .normal)
        self.setTitleColor(selectedTitleColor, for: .selected)
        self.titleLabel?.font = titleFont
    }
}
