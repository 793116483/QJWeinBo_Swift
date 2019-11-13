//
//  QJOauthNetworkTool.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/10.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJOauthNetworkTool: QJHTTPSessionManager {
    
    /// 获取 access_token
    class func loadAccessToken(code:String , seccess:((_ tokeModel:QJAccessTokenModel?)->())? ,  failuer:((_ error:Error?)->())?) {
        
        var parameters = [String : Any]()
        parameters["client_id"] = kAppKey_Oauth
        parameters["client_secret"] = kAppSecret_Oauth
        parameters["grant_type"] = "authorization_code"
        parameters["code"] = code
        parameters["redirect_uri"] = kRedirectUrl_Oauth

        self.post(URLString: "https://api.weibo.com/oauth2/access_token", parameters: parameters, success: { (obj) in
            
            let tokenModel = QJAccessTokenModel(dic: obj)
//            tokenModel?.setValue("好", forKey: "access_token")
            seccess?(tokenModel)
        }) { (error) in
            failuer?(error)
        }
    }
    
    /// 获取用户信息
    class func loadUserInfo(token:QJAccessTokenModel? , seccess:((_ userInfo:QJUserInfoModel?)->())? ,  failuer:((_ error:Error?)->())?) {
        
        guard let token = token else {
            failuer?(nil)
            return
        }
        
        var parameters = [String : Any]()
        parameters["access_token"] = token.access_token
        parameters["uid"] = token.uid

        self.get(URLString: "https://api.weibo.com/2/users/show.json", parameters: parameters, success: { (obj) in
            let userInfo = QJUserInfoModel(dic: obj , tokenInfo:token)
            seccess?(userInfo)
        }) { (error) in
            failuer?(error)
        }
    }
}
