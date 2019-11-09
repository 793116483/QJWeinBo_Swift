//
//  QJHomeViewController.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/7.
//  Copyright © 2019 yiniu. All rights reserved.
//  首页

import UIKit

class QJHomeViewController: QJBaseViewController {
    // titleView 展开弹窗
    private lazy var navTitlePopVc = QJNavTitlePopVc()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setUpUI()
    }
    


}

// MARK: 设置UI
extension QJHomeViewController {
    func setUpUI() {
        self.visitorView?.addRotationAnimtion()
        self.visitorView?.bgImageView.isHidden = false
        
        self.isLogin = true
        // 如果已经登录了
        if self.isLogin {
            setNavBar()
        }
    }
    /// 设置导航栏
    func setNavBar() {
        // 设置导航兰按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: nil, imageName: "navigationbar_friendattention", highlightedImageName: "navigationbar_friendattention_highlighted", style: .QJButtonStyleRight, touchEvent: (self,#selector(navBarLeftItemDidClickd)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, imageName: "navigationbar_pop", highlightedImageName: "navigationbar_pop_highlighted", style: .QJButtonStyleRight, touchEvent: (self,#selector(navBarRightItemDidClickd)))
        
        // 设置 titleView
        let titleView = QJButton(style: .QJButtonStyleRight)
        titleView.set(title: "我的账号名", image: "navigationbar_arrow_up", highlighted: "", selected: "navigationbar_arrow_down")
        titleView.addTarget(self, action: #selector(titleViewDidClicked), for: .touchUpInside)
        self.navigationItem.titleView = titleView
    }
    
    /// 弹出 or 隐藏 NavTitlePopVc 取决 isShow
    func showNavTitlePopVc(isShow:Bool) {
        if isShow {
            //        self.navTitlePopVc.modalPresentationStyle = .custom
            self.navTitlePopVc.loadViewIfNeeded()
            self.view.addSubview(self.navTitlePopVc.view)
            self.navTitlePopVc.view.width = 150
            self.navTitlePopVc.view.x = (self.view.width - self.navTitlePopVc.view.width)/2
            self.navTitlePopVc.view.y = 64 + 22
            
            UIView.animate(withDuration: 1) {
                self.navTitlePopVc.view.height = 200
            }
        }
        else{
            navTitlePopVc.dismiss(animated: true, completion: nil)
            UIView.animate(withDuration: 0, animations: {
                self.navTitlePopVc.view.height = 0
            }) { (se) in
                self.navTitlePopVc.view.removeFromSuperview()
            }
        }
    }
}

// MARK: 点击事件
extension QJHomeViewController {
    /// 导航兰左侧按钮被点击
    @objc func navBarLeftItemDidClickd(){
        QJPublic.Log("首页导航兰左侧按钮被点击")
    }
    /// 导航兰右侧按钮被点击
    @objc func navBarRightItemDidClickd(){
        QJPublic.Log("首页导航兰右侧按钮被点击")
    }
    /// navBar.titleView 被点击
    @objc func titleViewDidClicked() {
        guard self.navigationItem.titleView?.isKind(of: QJButton.self) == true else {
            return
        }
        guard let titleView = self.navigationItem.titleView as? QJButton else {
            return
        }
        titleView.isSelected = !titleView.isSelected
        
        
        // 弹出一个框
        showNavTitlePopVc(isShow: titleView.isSelected)
    }
    
}
