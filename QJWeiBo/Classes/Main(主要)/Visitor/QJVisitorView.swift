//
//  QJVisitorView.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/8.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJVisitorView: UIView {

    // MARK: 属性
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var centerImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    // MARK:获取visitorView的xib 并设置数据
    class func visitorView(_ centerImageName:String , text hitText: String?) -> QJVisitorView? {
        guard let visitorView = Bundle.main.loadNibNamed("QJVisitorView", owner: nil, options: nil)?.last as? QJVisitorView else{
            return nil
        }
        
        visitorView.setUpView(centerImageName, text: hitText)
        
        return visitorView
    }
    // MARK:设置数据
    func setUpView(_ centerImageName:String , text hitText: String?) {
        self.centerImageView.image = UIImage(named: centerImageName)
        self.textLabel.text = hitText
    }
    
    // MARK: 背景图添加动画
    func addRotationAnimtion() {
//        self.layer.transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1)
        let rotationAnimtion = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimtion.fromValue = 0
        rotationAnimtion.fromValue = -Double.pi * 2
        rotationAnimtion.repeatCount = MAXFLOAT
        rotationAnimtion.duration = 8
        // 如果切换到其他页面系统认为动画已完成，就会删除动画，要动画一直工作就设置false
        rotationAnimtion.isRemovedOnCompletion = false
        self.bgImageView.layer.add(rotationAnimtion, forKey: "动画标记")
    }
    
    @IBAction func registerBtnDidClicked(_ sender: UIButton) {
    }
    @IBAction func loginBtnDidClicked(_ sender: UIButton) {
    }
}
