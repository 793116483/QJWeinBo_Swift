//
//  QJHomeViewController.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/7.
//  Copyright © 2019 yiniu. All rights reserved.
//  首页

import UIKit

class QJHomeViewController: QJBaseViewController {
    // MARK: 属性
    // titleView 展开弹窗
    private lazy var navTitlePopView:QJNavTitlePopView = {
       let popView = QJNavTitlePopView()
        popView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height)
        popView.delegate = self
        return popView
    }()
    private lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none
//        tableView.showsVerticalScrollIndicator = false
        tableView.register(QJHomeTableViewCell.self, forCellReuseIdentifier: "QJHomeTableViewCell")
        
        return tableView
    }()
    /// 微博数据
    private lazy var statuses:[QJStatuseModel] = [QJStatuseModel]()
    /// 临时cell用来计算高度的
    private let cellTmp = QJHomeTableViewCell()
    
    
    // MARK: 方法
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
        // 下载数据
        loadStatuses()
    }

}

// MARK: 获取网络数据
extension QJHomeViewController{
    /// 加载首页微博数据
    private func  loadStatuses(){
        guard let access_token = QJUserInfoModel.userInfo?.tokenInfo?.access_token else{
            return
        }
        let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
        let parameters = ["access_token":access_token , "count":100] as [String : Any]
        QJHTTPSessionManager.get(URLString: urlStr, parameters: parameters, success: { (objc) in
            
            let statuses:[[String:Any]] = objc?["statuses"] as! [[String : Any]]
//            Log(statuses)
            
            for item in statuses {
                let statuse = QJStatuseModel.model(with: item)
                self.statuses.append(statuse!)
            }
            self.tableView.reloadData()
            
        }) { (error) in
            Log(error)
        }
    }
}

// MARK: 设置UI
private extension QJHomeViewController {
    func setUpUI() {
        self.visitorView?.addRotationAnimtion()
        self.visitorView?.bgImageView.isHidden = false
        
        // 如果已经登录了
        if QJUserInfoModel.isLogin {
            setNavBar()
            
            // 添加 tableView
            self.view.addSubview(self.tableView)
            tableView.mas_makeConstraints {[weak self] (make) in
                make?.top.equalTo()(self?.view)
                make?.bottom.equalTo()(self?.view)
                make?.left.equalTo()(self?.view)
                make?.right.equalTo()(self?.view)
            }
        }
    }
    /// 设置导航栏
    func setNavBar() {
        // 设置导航兰按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: nil, imageName: "navigationbar_friendattention", highlightedImageName: "navigationbar_friendattention_highlighted", style: .QJButtonStyleRight, touchEvent: (self,#selector(navBarLeftItemDidClickd)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, imageName: "navigationbar_pop", highlightedImageName: "navigationbar_pop_highlighted", style: .QJButtonStyleRight, touchEvent: (self,#selector(navBarRightItemDidClickd)))
        
        // 设置 titleView
        let titleView = QJButton(style: .QJButtonStyleRight)
        titleView.set(title: QJUserInfoModel.userInfo?.screen_name, image: "navigationbar_arrow_down", highlighted: "", selected: "navigationbar_arrow_up")
        titleView.addTarget(self, action: #selector(titleViewDidClicked), for: .touchUpInside)
        self.navigationItem.titleView = titleView
        
    }
}

// MARK: 点击事件
private extension QJHomeViewController  {
    /// 导航兰左侧按钮被点击
    @objc func navBarLeftItemDidClickd(){
        Log("首页导航兰左侧按钮被点击")
    }
    /// 导航兰右侧按钮被点击
    @objc func navBarRightItemDidClickd(){
        Log("首页导航兰右侧按钮被点击")
    }
    /// navBar.titleView 被点击
    @objc func titleViewDidClicked() {
        guard self.navigationItem.titleView?.isKind(of: QJButton.self) == true else {
            return
        }
        guard let titleView = self.navigationItem.titleView as? QJButton else {
            return
        }
        titleView.isSelected = !titleView.isSelected
        
        
        // 弹出 或 隐藏 navTitlePopView
        if titleView.isSelected {
            self.view.addSubview(self.navTitlePopView)
        }
        self.navTitlePopView.animation(isShow: titleView.isSelected) {
            if titleView.isSelected == false {
                self.navTitlePopView.removeFromSuperview()
            }
        }
    }
    
}


// MARK: UITableViewDataSource & UITableViewDelegate
extension QJHomeViewController: UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statuses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        return QJHomeTableViewCell.cell(with: tableView, statuse: self.statuses[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cellTmp.statuse = self.statuses[indexPath.row]
        return cellTmp.cellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Log(self.statuses[indexPath.row].retweeted_status)
    }
}

// MARK: QJNavTitlePopViewDelegate
extension QJHomeViewController : QJNavTitlePopViewDelegate{
    func didClickedBackgroundView() {
        titleViewDidClicked()
    }
}
