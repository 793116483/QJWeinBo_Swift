//
//  QJHTTPSessionManager.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/9.
//  Copyright © 2019 yiniu. All rights reserved.
//

import AFNetworking

class QJHTTPSessionManager: NSObject  {
    /// 单例类
    static let shareManager:AFHTTPSessionManager = {
       let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes?.insert("text/html")
        
        return manager
    }()
    
}

extension QJHTTPSessionManager {
    
    class func get(URLString:String , parameters:Any? , success: ((_ responseObj:Any?)->())? , failure:((_ error:Error)->())?) {
        QJHTTPSessionManager.shareManager.get(URLString, parameters: parameters, progress: nil, success: { (_:URLSessionDataTask, responseObj) in
            QJPublic.Log(responseObj)
            success?(responseObj)
        }) { (_, error:Error) in
            QJPublic.Log(error)
            failure?(error)
        }
    }
    
    class func post(URLString:String , parameters:Any? , success: ((_ responseObj:Any?)->())? , failure:((_ error:Error)->())?) {
        
        QJHTTPSessionManager.shareManager.post(URLString, parameters: parameters, progress: nil, success: { (_:URLSessionDataTask, responseObj) in
            QJPublic.Log(responseObj)
            success?(responseObj)
        }) { (_, error:Error) in
            QJPublic.Log(error)
            failure?(error)
        }
    }
}
