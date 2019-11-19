//
//  QJEmojiModel.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/19.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJEmojiModel: NSObject {

    /// emoji表情
    var code:String?
    /// 表情图片
    var chs:String?
    /// 表情文字
    var png:String?
    // 是否是 空模型
    var isEmpty = false
    // 是否是 删除模型
    var isDelete = false
    
    init(dic:[String: Any]?) {
        super.init()
        guard let dic = dic else {
            isEmpty = true
            return
        }
        self.code = dic["code"] as? String
        self.chs = dic["chs"] as? String
        self.png = dic["png"] as? String
        self.isDelete = dic["isDelete"] as? Bool ?? false
        
        resetCode()
        resetPng()
    }
    func resetCode() {
        guard let code = code else {
            return
        }
        let scanner = Scanner(string: code)
        var result:UInt64 = 0
        scanner.scanHexInt64(&result)
        guard let unicodeResult = UnicodeScalar(UInt32(result)) else {
            return
        }
        
        self.code = String(Character(unicodeResult))
    }
    func resetPng()  {
        guard let png = png else {
            return
        }
        self.png = Bundle.main.bundlePath + "/Emoticons.bundle/\(png)"
    }
    
}
