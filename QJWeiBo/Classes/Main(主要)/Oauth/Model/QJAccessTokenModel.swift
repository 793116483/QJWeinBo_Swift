//
//  QJAccessTokenModel.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/10.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJAccessTokenModel: NSObject , NSCoding{
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
    
    /// 字典 转 模型
    init(dic:[String:Any]?) {
        guard let dic = dic else {
            return
        }
        self.access_token = dic["access_token"] as? String
        self.expires_in = dic["expires_in"] as? TimeInterval ?? 0
        self.uid = dic["uid"] as? String
    }
    
    // MARK: 归档 & 解档
    func encode(with coder: NSCoder) {
        coder.encode(self.access_token, forKey: "access_token")
        coder.encode(self.expires_in, forKey: "expires_in")
        coder.encode(self.uid, forKey: "uid")

    }
    
    required init?(coder: NSCoder) {
        self.access_token = coder.decodeObject(forKey: "access_token") as? String
        self.expires_in = coder.decodeDouble(forKey: "expires_in") as TimeInterval
        self.uid = coder.decodeObject(forKey: "uid") as? String
    }
}

