//
//  QJAccessTokenModel.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/10.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJAccessTokenModel: NSObject {
    // MAKR: 属性
    /// token
    var access_token : String?
    /// token的无效时间，从获取到后开始算，时间戳
    var expires_in:TimeInterval = 0
    /// 过期日期
    lazy var expires_date : NSDate = {
        NSDate(timeIntervalSinceNow: self.expires_in)
    }()
    
    /// 授权用户的UID
    var uid:String?
    
    init(dic:[String:Any]?) {
        guard let dic = dic else {
            return
        }
        self.access_token = dic["access_token"] as? String
        self.expires_in = dic["expires_in"] as? TimeInterval ?? 0
        self.uid = dic["uid"] as? String
    }
}
