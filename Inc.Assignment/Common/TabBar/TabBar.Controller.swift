//
//  TabBar.Controller.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 11/07/2021.
//

import UIKit

class TabBarController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)

        tabBar.isTranslucent = false

        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true

        let controllers = [albumViewController,
                           favoritesViewController
        ]

        viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
            
        }
        

    }

    public let albumViewController: Album.ViewController = {
        let viewModel = Album.ViewModel(api: API.Manager())
        let viewController = Album.ViewController(viewModel: viewModel)
        viewController.tabBarItem = UITabBarItem(
            title: "Albums",
            image: UIImage(systemName: "square.stack"),
            tag: 0
        )
        return viewController
    }()

    public let favoritesViewController: Favorites.ViewController = {
        let viewModel = Favorites.ViewModel(api: API.Manager())
        let viewController = Favorites.ViewController(viewModel: viewModel)
        viewController.tabBarItem = UITabBarItem(
            title: "Favorites",
            image: UIImage(systemName: "heart.fill"),
            tag: 1
        )

        return viewController
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
