//
//  QJEmojiGroupModel.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/19.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJEmojiGroupModel: NSObject {

    var emojiModels = [QJEmojiModel]()
    init(souceName:String) {
        
        if souceName.isEmpty {
//            for var i in 0..<20 {
//                emojiModels.append(QJEmojiModel(dic: nil))
//            }
//            let deleteDic = ["isDelete":true , "png":"compose_emotion_delete@2x.png"] as [String : Any]
//            emojiModels.append(QJEmojiModel(dic: deleteDic))
        }
        else{
            let path = Bundle.main.path(forResource: "info.plist", ofType: nil, inDirectory: "Emoticons.bundle/\(souceName)")
            guard let infoPath = path  else {
                return
            }
            // 表情字典转模型
            let infoArr = NSArray(contentsOfFile: infoPath)! as! [[String:String]]
            for var dic in infoArr {
                if dic["png"] != nil {
                    dic["png"] = "\(souceName)/\(dic["png"]!)"
                }
                emojiModels.append(QJEmojiModel(dic: dic))
            }
//            // 插入空表情
//            let emptyCount = 20 - infoArr.count % 20 ;
//            for var i in 0..<emptyCount {
//                emojiModels.append(QJEmojiModel(dic: nil))
//            }
            // 插入删除按钮
//            for i in stride(from: emojiModels.count, to: 19, by: -20) {
//                Log(i)
//                let deleteDic = ["isDelete":true , "png":"compose_emotion_delete@2x.png"] as [String : Any]
//                emojiModels.insert(QJEmojiModel(dic: deleteDic), at: i)
//            }
        }
        
    }
}
