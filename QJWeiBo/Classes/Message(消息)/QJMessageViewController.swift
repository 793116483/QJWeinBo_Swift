//
//  QJMessageViewController.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/7.
//  Copyright © 2019 yiniu. All rights reserved.
//  消息

import UIKit

class QJMessageViewController: QJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.visitorView?.setUpView("visitordiscover_image_message", text: "这里是消息页这里是消息页这里是消息页这里是消息页这里是消息页这里是消息页这里是消息页这里是消息页这里是消息页")
        
        // Do any additional setup after loading the view.
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
