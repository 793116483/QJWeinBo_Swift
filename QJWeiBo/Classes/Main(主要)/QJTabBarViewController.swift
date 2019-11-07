//
//  QJTabBarViewController.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/7.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initTabBarVc()
    }
    
}

// MARK: 初始化 tab bar vc
private extension QJTabBarViewController {
     func initTabBarVc() {
        // 设置tabBar颜色
        self.tabBar.tintColor = UIColor.orange
        
        // Do any additional setup after loading the view.
        // 添加首页
        self.addChildViewController(vcName: "QJHomeViewController", title: "首页", imageName: "tabbar_home")
        // 添加消息
        self.addChildViewController(vcName: "QJMessageViewController", title: "消息", imageName: "tabbar_message_center")
        // 添加发现
        self.addChildViewController(vcName: "QJDiscoverViewController", title: "发现", imageName: "tabbar_discover")
        // 添加我的
        self.addChildViewController(vcName: "QJProfileViewController", title: "我", imageName: "tabbar_profile")
    }
    // 添加子控制器
     func addChildViewController(vcName:String , title:String , imageName:String) {
        
        // 1.获取命名空间,从info.plist中取命名空间就是项目名QJWeiBo
        guard let nameSpace = Bundle.main.infoDictionary![kCFBundleExecutableKey as String] as? String else {
            print("未找到命名空间")
            return
        }
        // 2.根据字符串获取class
        guard let vcClass = NSClassFromString(nameSpace + "." + vcName) else {
            print("未找到对应的class")
            return
        }
        // 3.对AnyClass转成控制器类型
        guard let vcType = vcClass as? UIViewController.Type else {
            return
        }
        let vc = vcType.init()
        
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName+"_highlighted")
        let nav = QJNavigationViewController(rootViewController: vc)
        self.addChild(nav)
    }
}
