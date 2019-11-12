//
//  NSDate+QJExtension.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/12.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

extension Date {
        
    /// 根据日期的字符串与格式创建 日期
    /// - Parameter dateStr: 如 "Tue Nov 01 20:44:08 +0800 2019"
    ///                          (即 星期 月 日 时:分:秒 时区 年)
    /// - Parameter dateFormat:  如 "EEE MM dd HH:mm:ss Z yyyy"
    /// - Parameter locale: 区域
    static func date(from dateStr:String? , format dateFormat:String , locale:Locale = Locale(identifier: "en")) -> Date? {
        
        guard let dateStr = dateStr else {
            return nil
        }
        
        let format = DateFormatter()
        format.dateFormat = dateFormat
        format.locale = locale

        return format.date(from: dateStr)
    }
    
    /// 当前的日期离现在的日期 该显示的 文字
    func showTextSinceNow() -> String {
        
        // 现在的日期
        let nowDate = Date()
        
        let timeInterval = Int(nowDate.timeIntervalSince(self))
        // 小于60s
        if timeInterval < 60 {
            return "刚刚"
        }
        else if(timeInterval < 60*60){
            return "\(timeInterval/60)分钟前"
        }else if(timeInterval < 60*60 * 24){
            return "\(timeInterval/(60*60))小时前"
        }else{
            // 日历
            let calendar = NSCalendar.current
            let format = DateFormatter()
            
            // 昨天的时间
            if calendar.isDateInYesterday(self) {
                format.dateFormat = "昨天 HH:mm"
            }
            // 在同一年内 : MM-dd HH:mm
            else if calendar.isDate(self, equalTo: Date(), toGranularity: .year) {
                format.dateFormat = "MM-dd HH:mm"
            }
            // 不同年
            else{
                format.dateFormat = "yyyy MM-dd HH:mm"
            }
            
            return format.string(from: self)
        }
    }
}
