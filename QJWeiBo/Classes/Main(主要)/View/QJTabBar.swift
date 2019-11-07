//
//  QJTabBar.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/7.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJTabBar: UITabBar {
    
    var items_ = [QJButton]()
    var selectedItem_ :QJButton?
    var selectedIndexBlock:((_ index:Int)->())?
    
    
    /// 设置文字 与 图片
    func addItem(title:String? , image imageName:String , selectImage selectImageName:String){
        let button = QJButton(type: .custom)
        button.set(title: title, image: imageName, selectImage: selectImageName)
        button.set()
        button.addTarget(self, action: #selector(itemDidSelected(item:)), for: .touchDown)
        
        self.addItem(item: button)
    }
    func addItem(item:QJButton) {
        item.tag = self.items_.count
        self.addSubview(item)
        self.items_.append(item)
    }
    
    /// item被点击
    @objc func itemDidSelected(item:QJButton) {
        // 防重复点击
        if let selectItm = self.selectedItem_{
            if selectItm.tag == item.tag {
                return
            }
        }
        self.selectedItem_?.isSelected = false
        self.selectedItem_ = item
        self.selectedItem_?.isSelected = true
        
        // 点击事件回调
        self.selectedIndexBlock?(item.tag)
        
    }
    
    /// 布局子控件
    override func layoutSubviews() {
        guard self.items_.count > 0 else {
            return
        }
        let itemW = self.width / CGFloat(self.items_.count)
        for i in 0..<self.items_.count {
            let item = self.items_[i]
            item.frame = CGRect(x: CGFloat(i) * itemW, y: 0, width: itemW, height: self.height)
        }
    }
}
