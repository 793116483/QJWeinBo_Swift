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
    private lazy var navTitlePopView = QJNavTitlePopView()
    
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
        
        // 如果已经登录了
        if QJUserInfoModel.isLogin {
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
        titleView.set(title: QJUserInfoModel.userInfo?.screen_name, image: "navigationbar_arrow_up", highlighted: "", selected: "navigationbar_arrow_down")
        titleView.addTarget(self, action: #selector(titleViewDidClicked), for: .touchUpInside)
        self.navigationItem.titleView = titleView
    }
    
    /// 弹出 or 隐藏 NavTitlePopVc 取决 btn.isSelected
    func showNavTitlePopVc(click btn:QJButton ) {
        btn.isEnabled = false
        if btn.isSelected { // 显示
            
            self.view.addSubview(self.navTitlePopView)
            self.navTitlePopView.width = 150
            self.navTitlePopView.x = (self.view.width - self.navTitlePopView.width)/2
            self.navTitlePopView.y = self.view.safeAreaInsets.top //  self.view.safeAreaInsets.top 是所有机形的navBar高度 
            self.navTitlePopView.clipsToBounds = true
            self.navTitlePopView.height = 200
            let animation = QJBasicAnimation(duration: 0.5, keyPath: "transform.scale.y", fromValue: 0.0, toValue: 1.0 , completion: { [weak self] (isFinish) in
                self?.navTitlePopView.layer.removeAllAnimations()
                btn.isEnabled = true
            })
            // 添加核心动画
            self.navTitlePopView.layer.add(animation, forKey: "nil")
        }
        else{ // 隐藏

            let animation = QJBasicAnimation(
                duration: 0.5,
                keyPath: "transform.scale.y",
                fromValue: 1.0,
                toValue: 0.001,  // 0.001 是因为苹果处理边界值时不是很灵
                
                completion: { [weak self] (isFinish) in
                    self?.navTitlePopView.removeFromSuperview()
                    self?.navTitlePopView.layer.removeAllAnimations()
                    btn.isEnabled = true
                }
            )
            
            // 添加核心动画
            self.navTitlePopView.layer.add(animation, forKey: "nil")
        }
    }
}

// MARK: 点击事件
extension QJHomeViewController {
    /// 导航兰左侧按钮被点击
    @objc func navBarLeftItemDidClickd(){
        Log("首页导航兰左侧按钮被点击")
    }
    /// 导航兰右侧按钮被点击
    @objc func navBarRightItemDidClickd(){
        Log("首页导航兰右侧按钮被点击")
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
        showNavTitlePopVc(click: titleView)
    }
    
}
