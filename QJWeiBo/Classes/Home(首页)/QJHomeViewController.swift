//
//  QJHomeViewController.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/7.
//  Copyright © 2019 yiniu. All rights reserved.
//  首页

import UIKit

class QJHomeViewController: QJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.visitorView?.addRotationAnimtion()
        self.visitorView?.bgImageView.isHidden = false
    }
    


}
