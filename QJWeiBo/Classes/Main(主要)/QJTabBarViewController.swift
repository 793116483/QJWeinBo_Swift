//
//  QJTabBarViewController.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/7.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJTabBarViewController: UITabBarController {

    /// 自定义的tabBar,是添加到系统的tabBar做子控件
    let tabBarView:QJTabBar = QJTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化
        self.initTabBarVc()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for item in self.tabBar.subviews {
            if item.isKind(of: QJTabBar.self) == false {
                item.removeFromSuperview()
            }
        }
    }
}

// MARK: 初始化 tab bar vc
private extension QJTabBarViewController {
    /// 初始化
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
        
        // 初始化 tabBarView
         // 防止循环引用
        self.tabBarView.selectedIndexBlock = {[weak self](index:Int) in
            QJPublic.Log("index= \(index)")
            self?.selectedIndex = index
        }
        self.tabBarView.frame = self.tabBar.bounds
        self.tabBar.addSubview(self.tabBarView)
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
        
        // 添加对应的tab bar item
        self.tabBarView.addItem(title: title, image: imageName, selectImage: imageName+"_highlighted")
    }
}
