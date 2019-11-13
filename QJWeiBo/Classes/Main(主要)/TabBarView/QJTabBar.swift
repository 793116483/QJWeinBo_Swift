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
    private var selectedItem_ :QJButton?
    var selectedIndex:Int = 0 {
        didSet{
            guard self.items_.count > selectedIndex else {
                Log("tabBar上未找到对应的index")
                return
            }
            self.itemDidSelected(item: self.items_[selectedIndex])
        }
    }
    /// item被点击选中后，外界需要做的事
    var selectedIndexBlock:((_ index:Int)->())?
    
}

// MARK: UI 相关
extension QJTabBar {
    
    /// 设置文字 与 图片
    func addItem(title:String? , image imageName:String , selectImage selectImageName:String){
        let button = QJButton(type: .custom)
        button.set(title: title, image: imageName, highlighted: selectImageName, selected: selectImageName)
        button.set()
        button.addTarget(self, action: #selector(itemDidSelected(item:)), for: .touchDown)
        button.style = .QJButtonStyleUp
        
        self.addItem(item: button)
    }
    
    /// 添加 item
    func addItem(item:QJButton) {
        item.tag = self.items_.count
        self.addSubview(item)
        self.items_.append(item)
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
// MARK: 点击事件
private extension QJTabBar {
    /// item 被主动点击
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
        
        self.selectedIndex = item.tag
        
        // 点击事件回调
        self.selectedIndexBlock?(item.tag)
    }
    
}
