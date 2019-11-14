//
//  QJNavTitlePopView.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/8.
//  Copyright © 2019 yiniu. All rights reserved.
//  首页 titleView 被点击展开的 view

import UIKit

class QJNavTitlePopView: UIView {
    private let bgGrayView = UIView()

    private let contentView = UIView()
    private let bgImageView  = UIImageView(image: UIImage(named: "popover_background"))
    private let tableView = UITableView()
    
    weak var delegate : QJNavTitlePopViewDelegate?
    
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
    private func setUpUI() {
        self.addSubview(self.bgGrayView)
        self.addSubview(self.contentView)
        self.contentView.addSubview(self.bgImageView)
        self.contentView.addSubview(self.tableView)
        
        self.bgGrayView.backgroundColor = UIColor.lightGray
        self.bgGrayView.alpha = 0.2
        // 作动画用
        self.contentView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0001)
        // 添加点击背景手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapBgGrayView))
        self.bgGrayView.addGestureRecognizer(tapGesture)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgGrayView.frame = self.bounds
        
        contentView.width = 150
        contentView.frame = CGRect(x: (self.width - contentView.width)/2, y: 0, width: 150, height: 200)
        contentView.clipsToBounds = true
        
        bgImageView.frame = contentView.bounds
        let space:CGFloat = 20
        tableView.frame = CGRect(x:space , y:space , width:contentView.width - space * 2, height: contentView.height - space * 2)
    }
}

// MARK: 点击事件
extension QJNavTitlePopView {
    /// 点击背景
    @objc func tapBgGrayView(){
        delegate?.didClickedBackgroundView()
    }
}

// MARK: 动画
extension QJNavTitlePopView {
    func animation(isShow:Bool , finish:(()->())?) {
        if isShow { // 显示
            let animation = QJBasicAnimation(duration: 0.5, keyPath: "transform.scale.y", fromValue: 0.0, toValue: 1.0 , completion: { [weak self] (isFinish) in
                self?.contentView.layer.removeAllAnimations()
                finish?()
            })
            // 添加核心动画
            self.contentView.layer.add(animation, forKey: "nil")
        }
        else{ // 隐藏

            let animation = QJBasicAnimation(
                duration: 0.5,
                keyPath: "transform.scale.y",
                fromValue: 1.0,
                toValue: 0.001,  // 0.001 是因为苹果处理边界值时不是很灵
                
                completion: { [weak self] (isFinish) in
                    self?.contentView.layer.removeAllAnimations()
                    finish?()
                }
            )
            // 添加核心动画
            self.contentView.layer.add(animation, forKey: "nil")
        }
    }
}

// MARK: QJNavTitlePopViewDelegate
@objc protocol QJNavTitlePopViewDelegate {
    @objc func didClickedBackgroundView()
}
