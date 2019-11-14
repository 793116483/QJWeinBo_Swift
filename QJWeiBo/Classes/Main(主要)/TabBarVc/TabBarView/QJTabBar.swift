//
//  QJTabBar.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/7.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJTabBar: UIView {
    
    /// 存放 item view
    var items_ = [QJButton]()
    private var selectedItem_ :QJButton?
    var selectedIndex:Int = 0 {
        
        didSet{
            guard self.items_.count > selectedIndex || selectedIndex < 0 else {
                Log("tabBar上未找到对应的index")
                return
            }
            self.itemDidSelected(item: self.items_[selectedIndex])
        }
    }
    /// QJTabBar delegate
    weak var delegate: QJTabBarDelegate?
    
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
        
        // 调用必须实现的代理方法 ， 如果调用可选方法就 delegate?.tabBar?(...)
        delegate?.tabBar(tabBar: self, didSelect: selectedIndex)
    }
    
}


// MARK: QJTabBarDelegate 代理协议方法
/// @objc QJTabBarDelegate 不一定要继成 NSObjectProtocol
@objc protocol QJTabBarDelegate  {
    /// item被点击选中 通知外界
   func tabBar(tabBar:QJTabBar , didSelect index:Int)
    /// 这种写法是声明 可选 必须加上 @objc
//   @objc optional func tabBar2(tabBar:QJTabBar , didSelect index:Int)
}
