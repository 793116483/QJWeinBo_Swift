//
//  QJBasicAnimation.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/9.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJBasicAnimation : CABasicAnimation  {
    // 设置一个邦定key的属性
    private var completion:((Bool)->())?
    
    convenience init(duration:CFTimeInterval ,
                     keyPath path:String? ,
                     fromValue:Any? ,
                     toValue:Any? ,
                     completion:((Bool)->())? = nil
                    ) {
        self.init()
        
        self.duration = duration
        self.keyPath = path
        self.fromValue = fromValue
        self.toValue = toValue
        self.completion = completion
        self.delegate = self
    }
    
}
// MARK: CAAnimationDelegate
extension QJBasicAnimation : CAAnimationDelegate {
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.completion?(flag)
    }
    
}
