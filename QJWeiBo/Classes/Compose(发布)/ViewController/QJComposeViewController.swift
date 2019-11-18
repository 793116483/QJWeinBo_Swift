//
//  QJComposeViewController.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/15.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit

class QJComposeViewController: QJBaseViewController {

    let textView = QJTextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        guard QJUserInfoModel.isLogin else {
            return
        }
        setUpNavBar()
        setUpTextView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()

    }
}

// MARK: UI相关
extension QJComposeViewController {
    /// 初始化导航栏
    func setUpNavBar() {
        let titleView = UILabel()
        titleView.text = "发微博"
        self.navigationItem.titleView = titleView
        let rightBtn = UIButton(type: .custom)
        rightBtn.setTitle("发布", for: .normal)
        rightBtn.setTitleColor(.orange, for: .disabled)
        rightBtn.setTitleColor(.gray, for: .normal)
        rightBtn.isEnabled = false
        rightBtn.addTarget(self, action: #selector(rightBarButtonItemDidClicked), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }
    func setUpTextView() {
        self.textView.placeHolderLable.text = "分享新鲜事..."
        self.textView.delegate = self
        self.textView.frame = self.view.bounds
        self.textView.backgroundColor = .red
        self.view.addSubview(self.textView)
        self.textView.becomeFirstResponder()
    }
}

// MARK: 点击事件
private extension QJComposeViewController {
    @objc func rightBarButtonItemDidClicked(){
        
    }
}

// MARK: UITextViewDelegate
extension QJComposeViewController:UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.textView.placeHolderLable.isHidden = textView.hasText
        let rightBtn =  self.navigationItem.rightBarButtonItem?.customView as! UIButton
        rightBtn.isSelected = textView.hasText
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
}
