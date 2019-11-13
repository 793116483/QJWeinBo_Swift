//
//  QJNavTitlePopView.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/8.
//  Copyright © 2019 yiniu. All rights reserved.
//  首页 titleView 被点击展开的 view

import UIKit

class QJNavTitlePopView: UIView {
    
    let bgImageView  = UIImageView(image: UIImage(named: "popover_background"))
    let tableView = UITableView()
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: 设置UI
extension QJNavTitlePopView {
    func setUpUI() {
        self.addSubview(self.bgImageView)
        self.addSubview(self.tableView)
        
        self.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0001)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.bgImageView.frame = self.bounds
        
        let space:CGFloat = 20
        self.tableView.frame = CGRect(x:space , y:space , width:self.width - space * 2, height: self.height - space * 2)
    }
}
