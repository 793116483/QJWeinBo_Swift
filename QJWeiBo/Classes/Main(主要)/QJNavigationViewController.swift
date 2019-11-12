//
//  QJNavigationViewController.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/7.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearanceBarButtonItem = UIBarButtonItem.appearance()
        appearanceBarButtonItem.tintColor = UIColor.orange
        
    }
    
   
}

extension QJNavigationViewController{
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
           
           self.tabBarController?.tabBar.isHidden = self.viewControllers.count > 0

           super.pushViewController(viewController, animated: animated)
       }
       override func popViewController(animated: Bool) -> UIViewController? {
           
           self.tabBarController?.tabBar.isHidden = self.viewControllers.count > 2
           return super.popViewController(animated: animated)
       }
       override func popToRootViewController(animated: Bool) -> [UIViewController]? {
           self.tabBarController?.tabBar.isHidden = false
           return super.popToRootViewController(animated: animated)
       }
       override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
           let vcs:[UIViewController]? = super.popToViewController(viewController, animated: animated)
           
           self.tabBarController?.tabBar.isHidden = self.viewControllers.count > 2
           
           return vcs
       }
}
