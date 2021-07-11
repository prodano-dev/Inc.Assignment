//
//  AppDelegate.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 10/07/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        self.window?.rootViewController = TabBarController()
        self.window?.rootViewController?.navigationController?.setNavigationBarHidden(true, animated: false)
        self.window?.makeKeyAndVisible()

        return true
    }
}

