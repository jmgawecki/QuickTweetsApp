//
//  TwitterTabBarController.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 15/02/2021.
//

import UIKit

final class TwitterTabBarController: UITabBarController {

    
    // MARK: - Overrides and Initialisers
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
    }
    
    
    // MARK: - TabBar configuration
    
    
    private func configureTabBarController() {
        UITabBar.appearance().tintColor         = ColorsTwitter.twitterBlue
        UINavigationBar.appearance().tintColor  = ColorsTwitter.twitterBlue
        viewControllers                         = [configureSearchNC(), configureFavoriteNC()]
    }
    
    
    private func configureSearchNC() -> UINavigationController {
        let searchVC                            = UserSearchVC()
        searchVC.title                          = "Search"
        searchVC.tabBarItem                     = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    
    private func configureFavoriteNC() -> UINavigationController {
        let favoritesVC                         = FavoritesVC()
        favoritesVC.title                       = "Favorites"
        favoritesVC.tabBarItem                  = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesVC)
    }
}
