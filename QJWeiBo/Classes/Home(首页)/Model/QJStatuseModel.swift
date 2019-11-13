//
//  QJStatuseModel.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/12.
//  Copyright © 2019 yiniu. All rights reserved.
//  微博模型

import UIKit
import MJExtension

/// 每条微博模型
class QJStatuseModel: NSObject {

    // MARK: 属性
    /// 创建时间 , 使用 created_at_show 属性
    var created_at :String? {
        didSet{
            // created_at = "Tue Nov 01 20:44:08 +0800 2019"
            // 处理 创建时间显示文字
            guard let date = Date.date(from: created_at , format: "EEE MM dd HH:mm:ss Z yyyy") else {
                return
            }
            created_at_show = date.showTextSinceNow()
        }
    }
    /// 创建时间 的显示内容
    var created_at_show :String = ""
    
    /// 微博来源
    var source :String?
    /// 微博正文
    var text :String?
    /// 微博MID
    var mid :String?
    /// 发微博的用户信息
    var user:QJUserModel?
    /// 微博配图的 url字典数组，格式: [[thumbnail_pic: urlString]]
    var pic_urls:[[String:String]]?
    /// 转发数
    var reposts_count:Int = 0
    /// 评论数
    var comments_count:Int = 0
    /// 点赞数
    var attitudes_count:Int = 0

    
    
    // MARK: 方法
    
    class func model(with dic:[String:Any]) -> QJStatuseModel{
        
        let model = QJStatuseModel()
        
        model.user = QJUserModel.model(dic: dic["user"] as! [String:Any])
        model.created_at = dic["created_at"] as? String
        model.source = dic["source"] as? String
        model.text = dic["text"] as? String
        model.mid = dic["mid"] as? String
        model.pic_urls = dic["pic_urls"] as? [[String:String]]
        model.reposts_count = dic["reposts_count"] as? Int ?? 0
        model.comments_count = dic["comments_count"] as? Int ?? 0
        model.attitudes_count = dic["attitudes_count"] as? Int ?? 0
        
        // 处理 source
        model.dealSource()
        
        return model
    }
 
    /// 处理 source
     func dealSource() {
        
        // 处理 source "<a href=\"http://app.weibo.com/t/feed/1sxHP2\" rel=\"nofollow\">专业版微博</a>"
        guard let source = source else {
            return
        }
        guard source.contains("</a>") == true else {
            return
        }
        let loc = (source as NSString).range(of: ">").location + 1
        let length = (source as NSString).range(of: "</a").location - loc
        let subStr = (source as NSString).substring(with: NSRange(location: loc, length: length))
        self.source = "来自 \(subStr)"
    }
    
}


/// 每条微博的用户信息 模型
class QJUserModel: NSObject {
    // MARK: 属性
    /// 用户头象
    var profile_image_url :String?
    /// 用户名
    var screen_name :String?
    
    /// 认证类型 ， 使用 verifiedImage 属性
    var verified_type: Int = -1 {
        didSet{
            switch verified_type {
            case 0:
                verifiedImage = UIImage(named: "avatar_vip")
            case 2,3,5:
                verifiedImage = UIImage(named: "avatar_enterprise_vip")
            case 220:
                verifiedImage = UIImage(named: "avatar_grassroot")
            default:
                verifiedImage = nil
            }
        }
    }
    /// 是 verified_type 认证类型 对应的图片
    var verifiedImage: UIImage?
    
    /// 会员等级 , 使用 vipImage 属性
    var mbrank : Int = 0 {
        didSet{
            if mbrank > 0 && mbrank < 7 {
                vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
            }
            else{
                vipImage = nil
            }
        }
    }
    /// 是 mbrank 等级对应的图片
    var vipImage: UIImage?
    
    /// 创建模型对象类方法
    class func model(dic:[String:Any]) -> QJUserModel{
        let model = QJUserModel()
        
        model.profile_image_url = dic["profile_image_url"] as? String
        model.screen_name = dic["screen_name"] as? String
        model.verified_type = dic["verified_type"] as! Int
        model.mbrank = dic["mbrank"] as! Int
        
        return model
    }
    
}



