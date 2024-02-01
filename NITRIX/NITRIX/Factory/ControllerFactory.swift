//
//  ControllerFactory.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation
import UIKit

final class ControllerFactory {
    
    // Singleton pattern
    static var shared: ControllerFactory = {
        let instance = ControllerFactory()
        return instance
    }()
    
    // Search controller to be embeded
    func createUISearchController(placeholderText: String) -> UISearchController {
        let controller = UISearchController(searchResultsController: nil)
        
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.placeholder = placeholderText
        
        return controller
    }
}
