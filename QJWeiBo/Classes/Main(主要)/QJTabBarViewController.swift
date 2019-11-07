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
extension QJTabBarViewController {
    func initTabBarVc() {
        // 设置tabBar颜色
        self.tabBar.tintColor = UIColor.orange
        
        // Do any additional setup after loading the view.
        // 添加首页
        self.addChildViewController(vc: QJHomeViewController(), title: "首页", imageName: "tabbar_home")
        // 添加消息
        self.addChildViewController(vc: QJMessageViewController(), title: "消息", imageName: "tabbar_message_center")
        // 添加发现
        self.addChildViewController(vc: QJDiscoverViewController(), title: "发现", imageName: "tabbar_discover")
        // 添加我的
        self.addChildViewController(vc: QJProfileViewController(), title: "我", imageName: "tabbar_profile")
    }
    // 添加子控制器
    func addChildViewController(vc:UIViewController , title:String , imageName:String) {
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName+"_highlighted")
        let nav = QJNavigationViewController(rootViewController: vc)
        self.addChild(nav)
    }
}
