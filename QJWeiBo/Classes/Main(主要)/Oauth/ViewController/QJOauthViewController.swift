//
//  QJOauthViewController.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/10.
//  Copyright © 2019 yiniu. All rights reserved.
//
/*
appKey: 1505372190
AppSecret : ca3d22221f1e8a043ff9fd197b962355
回调地址 ： http://www.baidu.com
*/

import UIKit
import WebKit
import SVProgressHUD

class QJOauthViewController: UIViewController {

    private lazy var webView:UIWebView = {
        let webView = UIWebView()
        webView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        webView.frame = self.view.bounds
        webView.delegate = self
        
        return webView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        setUpNavBar()
        
        self.view.addSubview(self.webView)
        // 加载数据
        loadWebView()
    }

}

// MARK: 加载数据
private extension QJOauthViewController {
    
    /// 加载 登录授权页面
    func loadWebView() {
        
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(kAppKey_Oauth)&redirect_uri=\(kRedirectUrl_Oauth)"
        
        guard let url = URL(string: urlStr)  else {
            return
        }
        SVProgressHUD.show()
        // 加载页面
        self.webView.loadRequest(URLRequest(url: url))
    }
    
    /// 获取 access_token
    func loadAccessToken(code:String) {
        QJOauthNetworkTool.loadAccessToken(code: code, seccess: { (tokenModel) in
            
            self.loadUserInfo(token: tokenModel)
            
            Log(tokenModel)
            
        }) { (error) in
            Log(error)
        }
    }
    
    /// 获取用户信息
    func loadUserInfo(token:QJAccessTokenModel?) {
        
        QJOauthNetworkTool.loadUserInfo(token: token, seccess: { (userInfo) in
            Log(userInfo?.tokenInfo?.expires_date)
            
            // 归档用户数据
            QJUserInfoModel.userInfo = userInfo
            
            // 显示 欢迎界面
            self.showWelcomeVc()
            
        }) { (error) in
            Log(error)
        }
    }
}

// MARK: 设置UI
private extension QJOauthViewController {
    
    /// 设置 tab bar
    func setUpNavBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(close))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(fillMessage))
        
        self.title = "登录界面"
    }
    
    /// 显示 欢迎界面
    func showWelcomeVc() {
        // 先将当前控制器关掉
        self.dismiss(animated: false) {
            // 显示 欢迎界面
            UIApplication.shared.keyWindow?.rootViewController = QJLoginSeccessWelcomeVc()
        }
    }
}

// MARK: 点击事件监听
extension QJOauthViewController {
    /// 关闭当前控制器
    @objc private func close() {
        self.dismiss(animated: true, completion: nil)
    }
    /// 填充账号 与 密码
    @objc private func fillMessage() {
        let jsCode =
            """
            document.getElementById('userId').value='793116483@qq.com';
            document.getElementById('passwd').value='qj43122319930519';
            """
        self.webView.stringByEvaluatingJavaScript(from: jsCode)
    }
}

// MARK: UIWebView delegate 方法
extension QJOauthViewController : UIWebViewDelegate  {
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        Log(request.url)
        guard let url = request.url else {
            return false
        }
        // http://www.baidu.com/?code=d1c41bf54cfbc6ae986b10f22b056775
        let urlStr = url.absoluteString
        guard urlStr.contains(kRedirectUrl_Oauth) && urlStr.contains("code=")  else {
            return true
        }
        
        // 取出 code 来换取 access_token
        guard let code = urlStr.components(separatedBy: "code=").last else {
            return true
        }
        // 获取 access_token
        self.loadAccessToken(code: code)
        
        return false
    }
}
