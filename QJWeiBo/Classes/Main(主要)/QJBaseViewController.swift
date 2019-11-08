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
    
    // MARK: 初始化 visitorView
    private func setUpVisitorView() {
        self.visitorView = QJVisitorView.visitorView("visitordiscover_feed_image_house", text: "关注一些人，回这里看看有什么惊喜")
        visitorView?.bgImageView.isHidden = true
        visitorView?.frame = self.view.bounds
        // self.view = self.visitorView
        self.view = self.visitorView
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
