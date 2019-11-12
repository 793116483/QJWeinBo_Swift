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
        manager.responseSerializer.acceptableContentTypes?.insert("text/plain")

        return manager
    }()
    
}

extension QJHTTPSessionManager {
    
    class func get(URLString:String , parameters:Any? , success: ((_ responseObj:[String:Any]?)->())? , failure:((_ error:Error)->())?) {
        QJHTTPSessionManager.shareManager.get(URLString, parameters: parameters, progress: nil, success: { (_:URLSessionDataTask, responseObj) in
            
            success?(responseObj as? [String:Any])
            
        }) { (_, error:Error) in
            
            failure?(error)
        }
    }
    
    class func post(URLString:String , parameters:Any? , success: ((_ responseObj:[String:Any]?)->())? , failure:((_ error:Error)->())?) {
        
        QJHTTPSessionManager.shareManager.post(URLString, parameters: parameters, progress: nil, success: { (_:URLSessionDataTask, responseObj) in
            
            success?(responseObj as? [String:Any])
            
        }) { (_, error:Error) in
            
            failure?(error)
        }
    }
}
