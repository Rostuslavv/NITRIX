//
//  TabBarController.swift
//  NITRIX
//
//  Created by Rostyslav on 30.01.2024.
//

import UIKit

// MARK: - procotol HomeWireFrameProtocol
protocol HomeTabBarControllerProtocol: AnyObject {
    static func createHomeModule() -> UITabBarController
}

// MARK: HomeWireFrameProtocol
final class HomeTabBarController: HomeTabBarControllerProtocol {
    
    final class func createHomeModule() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let firstView = MovieListWireFrame.createMovieListModule()
        let firstTabBarIcon = UIImage(systemName: Constants.Views.Home.firstTabBarIcon)
        let firstTabBarText = Constants.Views.Home.firstTabBarText
        let firstTabBarItem = UITabBarItem(title: firstTabBarText, image: firstTabBarIcon, tag: 1)
        firstView.tabBarItem = firstTabBarItem
        
        let secondView = FavoritesViewWireFrame.createFavoritesViewModule()
        let secondTabBarIcon = UIImage(systemName: Constants.Views.Home.secondTabBarIcon)
        let secondTabBarText = Constants.Views.Home.secondTabBarText
        secondView.tabBarItem = UITabBarItem(title: secondTabBarText, image: secondTabBarIcon, tag: 2)
        
        tabBarController.viewControllers = [firstView, secondView]
        
        return tabBarController
    }
}
