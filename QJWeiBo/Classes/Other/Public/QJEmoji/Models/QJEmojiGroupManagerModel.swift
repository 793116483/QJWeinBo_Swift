//
//  QJEmojiGroupManagerModel.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/19.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJEmojiGroupManagerModel: NSObject {

    static let manager = QJEmojiGroupManagerModel()
    var groupModes = [QJEmojiGroupModel]()

    override init() {
        super.init()
        
        groupModes.append(QJEmojiGroupModel(souceName:""))
        groupModes.append(QJEmojiGroupModel(souceName:"com.sina.default"))
        groupModes.append(QJEmojiGroupModel(souceName:"com.apple.emoji"))
        groupModes.append(QJEmojiGroupModel(souceName:"com.sina.lxh"))
    }
    /// 通过 表情文字
    func searchEmojiPng(with chs:String?) -> String?{
        guard let chs = chs else {
            return nil
        }
        for group in self.groupModes {
            for emoji in group.emojiModels {
                if chs == (emoji.chs ?? "") {
                    return emoji.png
                }
            }
        }
        return nil
    }
}
