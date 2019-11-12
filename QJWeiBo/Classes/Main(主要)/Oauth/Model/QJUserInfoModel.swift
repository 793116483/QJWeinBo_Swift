//
//  QJUserInfoModel.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/10.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJUserInfoModel: NSObject {
    var screen_name :String?
    var avatar_large :String?
    var tokenInfo : QJAccessTokenModel?
    
    init(dic:[String:Any]? , tokenInfo:QJAccessTokenModel) {
        self.tokenInfo = tokenInfo
        guard let dic = dic else {
            return
        }
        self.screen_name = dic["screen_name"] as? String
        self.avatar_large = dic["avatar_large"] as? String
    }
}
