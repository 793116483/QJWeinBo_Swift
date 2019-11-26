//
//  AppDelegate.swift
//  QJWeiBo
//
//  Created by 瞿杰 on 2019/11/7.
//  Copyright © 2019 yiniu. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootVc = QJUserInfoModel.isLogin ? QJLoginSeccessWelcomeVc() : QJTabBarViewController()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = rootVc
        self.window?.makeKeyAndVisible()
        
        return true
    }

    // 在其他应用打开 weibo://host/path?query , weibo是自己配的 URL Schemes 协议
    // 从其他app跳转到当前app时，会调用该代理方法 , ios 9.0以后才会调这个方法
    // 如果从当前app 跳转到 其他app , ios9.0以后的 需要在info.plist添加 Schemes 到白名单 ，该Schemes是已经配制到其他app中
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
     
        print("open url : \(url) , options: \(options)")
        // 协议
        let scheme = url.scheme
        // 主机地址
        guard let host = url.host else {return false }
        // 路径
        let path = url.path
        // 传的参数 查询
        let query = url.query
        
        if host == "myWeiboHomePage" {
            print("跳转到我的微博首页")
        }
        
        return true
    }
    // ios 9.0 以前会调用这个方法
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        
        print("handleOpen url : \(url)")

        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }


    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "QJWeiBo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

