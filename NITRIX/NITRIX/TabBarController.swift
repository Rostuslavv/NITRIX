//
//  TabBarController.swift
//  NITRIX
//
//  Created by Rostyslav on 30.01.2024.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Створення екземпляру контролерів для табів
        let moviesListViewController = MoviesListViewController()
        let favoritesViewController = FavoritesViewController()

        // Створення екземплярів таббар-елементів
        let moviesListTabBarItem = UITabBarItem(title: "Movies List", image: nil, tag: 0)
        let favoritesTabBarItem = UITabBarItem(title: "Favorites", image: nil, tag: 1)

        // Призначення таббар-елементам контролерів
        moviesListViewController.tabBarItem = moviesListTabBarItem
        favoritesViewController.tabBarItem = favoritesTabBarItem

        // Призначення контролера таббару
        viewControllers = [moviesListViewController, favoritesViewController]
    }
}
