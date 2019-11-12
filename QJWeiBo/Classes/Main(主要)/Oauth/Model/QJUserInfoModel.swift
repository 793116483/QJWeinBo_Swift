//
//  QJUserInfoModel.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/10.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJUserInfoModel: NSObject , NSCoding{
    
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
    
    // MARK: 归档 & 解档
    func encode(with coder: NSCoder) {
        coder.encode(self.screen_name, forKey: "screen_name")
        coder.encode(self.avatar_large, forKey: "avatar_large")
        coder.encode(self.tokenInfo, forKey: "tokenInfo")
    }
    
    required init?(coder: NSCoder) {
        self.screen_name = coder.decodeObject(forKey: "screen_name") as? String
        self.avatar_large = coder.decodeObject(forKey: "avatar_large") as? String
        self.tokenInfo = coder.decodeObject(forKey: "tokenInfo") as? QJAccessTokenModel
    }
    
}

// MARK: 登录的用户信息 , 归档 & 解档 &
extension QJUserInfoModel {
    /// 用户是否登录 或 是否登录已经过期
    static var isLogin:Bool {

        guard let userInfo = QJUserInfoModel.userInfo else {
            return false
        }
        guard let expires_date = userInfo.tokenInfo?.expires_date else {
            return false
        }
        
        // 过期日期 > 当前日期 : 表示当前登录的用户还没有过期
        return expires_date.compare(Date()) == ComparisonResult.orderedDescending
    }
    
    /// 用户信息 在 沙盒中的 路径
    static var userInfoPath : String {
        let userInfoPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return (userInfoPath as NSString).appendingPathComponent("userInfo.plist")
    }
    /// 解档 : 用户信息的替代品 ， 只在读取的时候赋值一次
    private static var userInfo_tmp : QJUserInfoModel? = {
        return NSKeyedUnarchiver.unarchiveObject(withFile: userInfoPath) as? QJUserInfoModel
    }()
    ///
    static var userInfo : QJUserInfoModel? {
        get {
            self.userInfo_tmp
        }
        set{
            guard let userInfo = newValue else {
                return
            }
            NSKeyedArchiver.archiveRootObject(userInfo, toFile: userInfoPath)
        }
    }
}
