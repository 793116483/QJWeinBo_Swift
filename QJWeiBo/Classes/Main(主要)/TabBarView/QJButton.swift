//
//  QJButton.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/7.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

enum QJButtonStyle {
    /// 系统样式 , 默认的样式
    case QJButtonStyleSystem
    /// 图片在上，文字在下
    case QJButtonStyleUp
    /// 图片在右，文字在左
    case QJButtonStyleRight
}

class QJButton: UIButton {
    
    // MARK: 属性
    /// 按钮样式
    var style:QJButtonStyle {
        didSet{
            self.layoutIfNeeded()
        }
    }
    
    // MARK: 方法
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        self.style = .QJButtonStyleSystem

        super.init(frame: frame)
        
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.setTitleColor(UIColor.gray, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    init(style:QJButtonStyle) {
        self.style = .QJButtonStyleSystem
        self.init()
        self.style = style
    }
    
}

// MARK: 设置UI
extension QJButton {
    
    /// 设置文字 与 图片
    func set(title:String? , image imageName:String , highlighted imageName2:String , selected imageName3:String = ""){
        
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .selected)
        self.setImage(UIImage(named: imageName), for: .normal)
        self.setImage(UIImage(named: imageName2), for: .highlighted)
        self.setImage(UIImage(named: imageName3), for: .selected)
    }
    
    /// 设置文字的字体大小与颜色
    func set(titleFont:UIFont = UIFont.systemFont(ofSize: 14) , titleColor:UIColor = UIColor.gray , selectedTitleColor:UIColor = UIColor.orange) {
        self.setTitleColor(titleColor, for: .normal)
        self.setTitleColor(selectedTitleColor, for: .selected)
        self.titleLabel?.font = titleFont
    }
    
    /// 布局子控件
    override func layoutSubviews() {
        super.layoutSubviews()
        // 如果是系统类型就不用重新布局
        guard self.style != .QJButtonStyleSystem else {
            return
        }
        
        if self.style == .QJButtonStyleUp { // 上下样式
            var titleH:CGFloat = 0
            if self.titleLabel?.text?.isEmpty == false {
                titleH = 14
            }
            let space:CGFloat = 2
            self.imageView?.frame = CGRect(x: 0, y: space, width: self.width, height: self.height - 3*space - titleH)
            self.titleLabel?.frame = CGRect(x: 0, y: self.imageView!.height+space, width: self.width, height: titleH)
        }
        else { // 图片在右
            
            self.titleLabel?.sizeToFit()
            
            let space:CGFloat = 2
            let titleW = self.titleLabel?.width ?? 0
            let imageViewW = self.imageView?.width ?? 0
                        
            self.titleLabel?.x = ( self.width -  (titleW + space + imageViewW) ) / 2.0;
            self.imageView?.x = (self.titleLabel?.max_X ?? 0) + space
        }
    }
}
