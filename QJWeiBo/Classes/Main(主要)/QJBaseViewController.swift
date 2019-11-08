//
//  QJBaseViewController.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/7.
//  Copyright © 2019 yiniu. All rights reserved.
//  所有类的基类

import UIKit

class QJBaseViewController: UIViewController {

    var visitorView:QJVisitorView?
    var isLogin = false
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        isLogin ? super.viewDidLoad() : setUpVisitorView()
    }
    
}

// MARK: 设置UI
extension QJBaseViewController {
    
    /// 初始化 visitorView
    private func setUpVisitorView() {
        self.visitorView = QJVisitorView.visitorView("visitordiscover_feed_image_house", text: "关注一些人，回这里看看有什么惊喜")
        visitorView?.bgImageView.isHidden = true
        visitorView?.frame = self.view.bounds
        // self.view = self.visitorView
        self.view = self.visitorView
        // 两个按钮添加击点事件
        visitorView?.registerBtn.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        visitorView?.loginBtn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        // 设置导航按钮
        setUpNavItem()
    }
    /// 设置导航兰 注册 和 登录
    func setUpNavItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .done, target: self, action: #selector(registerAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(loginAction))

    }
    
}

// MARK: 监听点击事件
extension QJBaseViewController {
    /// 注册事件
    @objc func registerAction() {
        QJPublic.Log("注册")
    }
    /// 登录事件
    @objc func loginAction() {
        QJPublic.Log("登录")
    }
}
