//
//  AppDelegate.swift
//  ShowMoreText
//
//  Created by juanmao on 15/12/8.
//  Copyright © 2015年 juanmao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame:UIScreen.mainScreen().bounds)
        self.window?.makeKeyAndVisible()
        let viewVC = ViewController()
        let navVC = UINavigationController(rootViewController: viewVC)
        self.window?.rootViewController = navVC
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }


}

