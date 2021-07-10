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
        let api = API.Manager()
        let viewModel = Album.ViewModel(api: api)
        self.window?.rootViewController = UINavigationController(
            rootViewController: Album.ViewController(viewModel: viewModel)
        )
        self.window?.makeKeyAndVisible()

        return true
    }
}

