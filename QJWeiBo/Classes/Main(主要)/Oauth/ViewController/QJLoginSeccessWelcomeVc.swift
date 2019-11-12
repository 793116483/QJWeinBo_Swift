//
//  QJLoginSeccessWelcomeVc.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/12.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit
import Masonry
import SDWebImage


class QJLoginSeccessWelcomeVc: QJBaseViewController {

    private let bgImageView = UIImageView(image: UIImage(named: "ad_background"))
    private let iconImageView : UIImageView = {
       let imageV = UIImageView(image: UIImage(named: "avatar_default_big"))
        imageV.layer.cornerRadius = 85.0 / 2
        imageV.clipsToBounds = true
        
        return imageV
    }()
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
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: UInt64(0.5 * 1000000000))) {
            // Damping : 阻力系数
            UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5, options: [], animations: {
                self.iconImageView.y = 200
                self.hintLabel.y = 200 + self.iconImageView.height + 20
            }) { (isComp) in
                // 显示完动画后直接显示主页面
                UIApplication.shared.keyWindow?.rootViewController = QJTabBarViewController()
            }
        }
    }
}


// MARK: 设置UI
extension QJLoginSeccessWelcomeVc {
    /// 初始化UI
    private func setUI() {
        // 添加子控件
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
        
        /// 设置头象
        if let avatar_large = QJUserInfoModel.userInfo?.avatar_large {
            self.iconImageView.sd_setImage(with: URL(string: avatar_large), completed: nil)
        }
    }

}

