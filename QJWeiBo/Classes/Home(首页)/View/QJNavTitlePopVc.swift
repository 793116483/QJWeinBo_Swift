//
//  QJNavTitlePopVc.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/8.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJNavTitlePopVc: UIViewController {
    
    let bgImageView  = UIImageView(image: UIImage(named: "popover_background"))
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
}

// MARK: 设置UI
extension QJNavTitlePopVc {
    func setUpUI() {
        self.view.addSubview(self.bgImageView)
        self.view.addSubview(self.tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.bgImageView.frame = self.view.bounds
        
        let space:CGFloat = 20
        self.tableView.frame = CGRect(x:space , y:space , width:self.view.width - space * 2, height: self.view.height - space * 2)
    }
}
