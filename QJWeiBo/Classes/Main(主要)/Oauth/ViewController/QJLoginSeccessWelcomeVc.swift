//
//  QJLoginSeccessWelcomeVc.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/12.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit
import Masonry


class QJLoginSeccessWelcomeVc: QJBaseViewController {

    private let bgImageView = UIImageView(image: UIImage(named: "ad_background"))
    private let iconImageView = UIImageView(image: UIImage(named: "avatar_default_big"))
    private let hintLabel:UILabel = {
        let hintLabel = UILabel()
        hintLabel.text = "欢迎回来"
        hintLabel.textColor = UIColor.gray
        hintLabel.textAlignment = .center
        
        return hintLabel
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Damping : 阻力系数
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 2, initialSpringVelocity: 10, options: [], animations: {
            self.iconImageView.y = 100
        }) { (isComp) in
            
        }
    }
}


// MARK: 设置UI
extension QJLoginSeccessWelcomeVc {
    private func setUI() {
        self.view.addSubview(self.bgImageView)
        self.view.addSubview(self.iconImageView)
        self.view.addSubview(self.hintLabel)
        
        // 布局子控件位置
        self.bgImageView.mas_makeConstraints {[weak self] (make) in
            make?.top.equalTo()(self?.view.mas_top)
            make?.bottom.equalTo()(self?.view.mas_bottom)
            make?.left.equalTo()(self?.view.mas_left)
            make?.right.equalTo()(self?.view.mas_right)
        }
        self.hintLabel.mas_makeConstraints {[weak self] (make) in
            make?.centerX.equalTo()(self?.view.mas_centerX)
            make?.bottom.equalTo()(self?.view.mas_bottom)?.offset()(-130)
        }
        self.iconImageView.mas_makeConstraints { (make) in
            make?.width.mas_equalTo()(85)
            make?.height.equalTo()(85)
            make?.centerX.equalTo()(self.view.mas_centerX)
            make?.bottom.equalTo()(self.hintLabel.mas_top)?.offset()(-20)
        }
    }
    
    /// 设置头象
    func set(iconName:String)  {
        
        
        
    }
}

