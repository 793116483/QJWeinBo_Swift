//
//  QJFrame.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/7.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

extension UIView {

    var origin: CGPoint {
        get{
            self.frame.origin
        }
        set{
            self.frame = CGRect(origin: newValue, size: self.size)
        }
    }
    var size: CGSize {
        get{
            self.frame.size
        }
        set{
            self.frame = CGRect(origin:self.origin, size: newValue)
        }
    }
    var x: CGFloat {
        get{
            self.origin.x
        }
        set{
            self.origin = CGPoint(x: newValue, y: self.y)
        }
    }
    var y: CGFloat {
        get{
            self.origin.y
        }
        set{
            self.origin = CGPoint(x: self.x, y: newValue)
        }
    }
    
    var width: CGFloat {
        get{
            self.size.width
        }
        set{
            self.size = CGSize(width: newValue, height: self.height)
        }
    }
    var height: CGFloat {
        get{
            self.size.height
        }
        set{
            self.size = CGSize(width: self.width, height: newValue)
        }
    }
    
    var max_X: CGFloat {
        return self.x + self.width
    }
    var max_Y: CGFloat {
        return self.y + self.height
    }
}


