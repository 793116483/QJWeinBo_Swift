//
//  UIBarButtonItem+QJExtension.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/8.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName:String , highlightedImageName:String , touchEvent:(target:Any? , action:Selector)) {
        self.init()
        
        let customV = QJButton()
        customV.set(title: nil, image: imageName, highlighted: highlightedImageName)
        customV.addTarget(touchEvent.target, action: touchEvent.action, for: .touchUpInside)
        self.customView = customV
        
    }
    convenience init(title:String? , imageName:String , highlightedImageName:String , style:QJButtonStyle , touchEvent:(target:Any? , action:Selector)) {
        self.init()
        
        let customV = QJButton(style: style)
        customV.set(title: title, image: imageName, highlighted: highlightedImageName)
        customV.addTarget(touchEvent.target, action: touchEvent.action, for: .touchUpInside)
        
        self.customView = customV
    }
    
    
    convenience init(title:String? , imageName:String , selectImageName:String , style:QJButtonStyle , touchEvent:(target:Any? , action:Selector)) {
        self.init()
        
        let customV = QJButton(style: style)
        customV.set(title: title, image: imageName, highlighted: selectImageName , selected: selectImageName)
        customV.addTarget(touchEvent.target, action: touchEvent.action, for: .touchUpInside)

        self.customView = customV
    }
}

