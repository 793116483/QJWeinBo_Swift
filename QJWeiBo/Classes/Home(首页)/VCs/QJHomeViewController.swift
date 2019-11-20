//
//  QJHomeViewController.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/7.
//  Copyright © 2019 yiniu. All rights reserved.
//  首页

import UIKit
import MJRefresh

class QJHomeViewController: QJBaseViewController {
    // MARK: 属性
    // titleView 展开弹窗
    private lazy var navTitlePopView:QJNavTitlePopView = {
       let popView = QJNavTitlePopView()
        popView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.height)
        popView.delegate = self
        return popView
    }()
    private lazy var tableView = UITableView()
    /// 微博数据
    private lazy var statuses:[QJStatuseModel] = [QJStatuseModel]()
    /// 临时cell用来计算高度的
    private let cellTmp = QJHomeTableViewCell()
    
    
    // MARK: 方法
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setUpNotification()
    }
    
    // MARK: 添加通知
    private func setUpNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(showPicturePreview), name: homeCellPicturePreviewNotification, object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: homeCellPicturePreviewNotification, object: nil)
    }
}

// MARK: 获取网络数据
private extension QJHomeViewController{
    /// 下拉加载 首页最新的微博数据
    @objc private func  loadNewStatuses(){
        loadStatuses(isLodNew: true)
    }
    /// 上拉加载 首页更多的微博数据
    @objc private func loadMoreStatuses(){
        loadStatuses(isLodNew: false)
    }
    /// 加载首页更多的微博数据
    /// - Parameter isLodNew: 是否加载新发的微博,true or false
    @objc private func  loadStatuses(isLodNew:Bool){
        
        let access_token = QJUserInfoModel.userInfo?.tokenInfo?.access_token
        let count = 20
        // 获取请求参数
        let parameters:[String : AnyObject] = {
            var parameters = ["access_token":access_token , "count":count] as [String : AnyObject]
            if isLodNew {
                let since_id:String = self.statuses.first?.mid ?? "0"
                parameters["since_id"] = since_id as AnyObject
            }
            else{
                let max_id = (Int64(self.statuses.last?.mid ?? "0") ?? 0) - 1
                parameters["max_id"] = max_id as AnyObject
            }
            
            return parameters
        }()
        // 请求地址
        let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
        // 开始网络请求
        QJHTTPSessionManager.get(URLString: urlStr, parameters: parameters, success: { (objc) in
            
            // 刚下载的微博模型 数组
            let statusesArray:[QJStatuseModel] = {
                // 微博字典数组
                let statuseDics:[[String:Any]] = objc?["statuses"] as! [[String : Any]]
                // 转成微博模型
                var statusesArray = [QJStatuseModel]()
                for item in statuseDics {
                    let statuse = QJStatuseModel.model(with: item)
                    statusesArray.append(statuse!)
                }
                return statusesArray
            }()
            
            if isLodNew {
                // 拼接数据
                self.statuses = statusesArray + self.statuses
                // 结束刷新
                self.tableView.mj_header?.endRefreshing()
            }
            else{
                // 拼接数据
                self.statuses += statusesArray
                // 结束刷新 tableView
//                if statusesArray.count < count {
//                    self.tableView.mj_footer?.endRefreshingWithNoMoreData()
//                } else{
                    self.tableView.mj_footer?.endRefreshing()
//                }
            }
            
            // reload tableView
            self.tableView.reloadData()
            self.showRefreshData(count: statusesArray.count)
        }) { (error) in
            Log(error)
            
            // 关闭刷新
            isLodNew ? self.tableView.mj_header?.endRefreshing() : self.tableView.mj_footer?.endRefreshing()
        }
    }
}

// MARK: 设置UI
private extension QJHomeViewController {
    /// 初始化 UI
    func setUpUI() {
       guard QJUserInfoModel.isLogin else {
            // 未登录时的 view
            self.visitorView?.addRotationAnimtion()
            self.visitorView?.bgImageView.isHidden = false
            return
        }
        setUpNavBar()
        setUpTableView()
    }
    /// 设置导航栏
    func setUpNavBar() {
        // 如果已经登录了才重新设置
        guard QJUserInfoModel.isLogin else { return }
        
        // 设置导航兰按钮
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: nil, imageName: "navigationbar_friendattention", highlightedImageName: "navigationbar_friendattention_highlighted", style: .QJButtonStyleRight, touchEvent: (self,#selector(navBarLeftItemDidClickd)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, imageName: "navigationbar_pop", highlightedImageName: "navigationbar_pop_highlighted", style: .QJButtonStyleRight, touchEvent: (self,#selector(navBarRightItemDidClickd)))
        
        // 设置 titleView
        let titleView = QJButton(style: .QJButtonStyleRight)
        titleView.set(title: QJUserInfoModel.userInfo?.screen_name, image: "navigationbar_arrow_down", highlighted: "", selected: "navigationbar_arrow_up")
        titleView.addTarget(self, action: #selector(titleViewDidClicked), for: .touchUpInside)
        self.navigationItem.titleView = titleView
    }
    /// 初始化 tableView
    func setUpTableView() {
        // 如果已经登录了
        guard QJUserInfoModel.isLogin else { return }
        
        // 添加 tableView
        self.view.addSubview(self.tableView)
        tableView.mas_makeConstraints {[weak self] (make) in
            make?.top.equalTo()(self?.view)
            make?.bottom.equalTo()(self?.view)
            make?.left.equalTo()(self?.view)
            make?.right.equalTo()(self?.view)
        }
        
        // 刷新数据
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none
        tableView.register(QJHomeTableViewCell.self, forCellReuseIdentifier: "QJHomeTableViewCell")
        
        // 添加下拉刷新
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewStatuses))
        header.setTitle("下拉刷新", for: .idle)
        header.setTitle("松开后开始刷新", for: .pulling)
        header.setTitle("正在刷新", for: .refreshing)
        tableView.mj_header = header

        // 添加上拉刷新
        let footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreStatuses))
        tableView.mj_footer = footer
        
        // 初始下拉刷新
        tableView.mj_header?.beginRefreshing()
    }
    /// 显示 或 隐藏 navTitlePopView
    func showOrHiddenPopView() {
        guard self.navigationItem.titleView?.isKind(of: QJButton.self) == true else {
            return
        }
        guard let titleView = self.navigationItem.titleView as? QJButton else {
            return
        }
        // 设置 titleView 的选中状态
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
    /// 弹出刷新的个数提示
    static var isShowing = false
    func showRefreshData(count:Int) {
        
        DispatchQueue.global().async {
            while QJHomeViewController.isShowing != false { // 保证每次弹出就只有一个 hintLable 显示
            }
            DispatchQueue.main.async { // 弹出提示 view
                QJHomeViewController.isShowing = true
                let hintLable = UILabel(frame: CGRect(x: 0, y: self.view.safeAreaInsets.top, width: self.view.width, height: 30))
                hintLable.text = "更新\(count)条微博"
                hintLable.textColor = .white
                hintLable.layer.anchorPoint = CGPoint(x: 0.5, y: 0.001)
                hintLable.frame = CGRect(x: 0, y: self.view.safeAreaInsets.top, width: self.view.width, height: 30)
                hintLable.font = .systemFont(ofSize: 16)
                //        hintLable.backgroundColor = .orange
                hintLable.textAlignment = .center
                self.view.addSubview(hintLable)
                        
                // 颜色渐变
                let animationShow = QJBasicAnimation(duration: 1, keyPath: "backgroundColor", fromValue: UIColor.clear.cgColor, toValue: UIColor.orange.cgColor)
                hintLable.layer.add(animationShow, forKey: "animationShow")

                // 时间单位 秒
                let timeSecond = DispatchTime.init(uptimeNanoseconds: DispatchTime.now().uptimeNanoseconds + 3*1000000000)
                DispatchQueue.main.asyncAfter(deadline:timeSecond) {
                    let animationHidden = QJBasicAnimation(duration: 1, keyPath: "transform.scale.y", fromValue: 1.0, toValue: 0.001 ) { (isFinish) in
                        // 还原
                        hintLable.removeFromSuperview()
                        QJHomeViewController.isShowing = false
                    }
                    hintLable.layer.add(animationHidden, forKey: "animationHidden")
                }
            }
        }
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
        showOrHiddenPopView()
    }
    /// 显示图片预览
    @objc func showPicturePreview(noti:Notification){
        
        let info = noti.userInfo
        let previewVc = QJPhotoPreviewVc(pictureUrls: info?["pictureUrls"] as? [NSURL], indexPath: info?["indexPath"] as? NSIndexPath)
        self.present(previewVc, animated: true, completion: nil)
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
