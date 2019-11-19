//
//  QJToolBarView.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/19.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJToolBarView: UIView {

    var itemDidClickedBlock:((_ index:Int)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addItem(title: "最近", tag: 0)
        self.addItem(title: "默认", tag: 1)
        self.addItem(title: "emoji", tag: 2)
        self.addItem(title: "浪小花", tag: 3)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: UI
extension QJToolBarView{
    func addItem(title:String? , tag:Int) {
        let btn = UIButton(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.orange, for: .normal)
        btn.tag = tag
        btn.addTarget(self, action: #selector(itemDidClicked(item:)), for: .touchUpInside)
        self.addSubview(btn)
    }
}

extension QJToolBarView {
    @objc func itemDidClicked(item:UIButton) {
        self.itemDidClickedBlock?(item.tag)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.width / 4
        
        for btn in self.subviews {
            if btn.isKind(of: UIButton.self) {
                btn.frame = CGRect(x: width * CGFloat(btn.tag) , y: 0, width: width, height: self.height)
            }
        }
    }
}


