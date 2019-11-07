//
//  QJPublic.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/7.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJPublic: NSObject {
    /// 自定义打印方法
    // 全局函数
    class func Log(_ messages:Any... , fileName:String = (#file as NSString).lastPathComponent , function:String = #function,line:Int = #line) {
    //        #file
    //        #function
    //        #line
        #if DEBUG
        var meStr = ""
        
        for message in messages {
            if meStr.count > 0 {
                meStr += " , "
            }
            meStr += "\(message)"
        }
//        print("\(fileName)的\(function)方法(\(line)) : \(meStr)")
        print("\(function)方法(\(line)) : \(meStr)")
        #endif
    }
}
