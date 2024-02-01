//
//  ButtonFactory.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation
import UIKit

// MARK: - ButtonFactory
final class ButtonFactory {
    
    // Singleton pattern
    static var shared: ButtonFactory = {
        let instance = ButtonFactory()
        return instance
    }()
}


extension ButtonFactory {
    
    // Button system item
    func createUIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem, target: Any?, action: Selector?) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: barButtonSystemItem, target: target, action: action)
        return barButtonItem
    }
}


extension ButtonFactory {
    
    // Custom button
    func createToggleUIBarButtonItem(defaultValue: Bool, tintColor: UIColor = .systemBlue, target: Any?, action: Selector?) -> UIBarButtonItem {
        let switchControl = UISwitch(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 50, height: 30)))
        switchControl.isOn = defaultValue
        switchControl.onTintColor = tintColor
        switchControl.setOn(defaultValue, animated: false)
        if let action = action, let target = target {
            switchControl.addTarget(target, action: action, for: .valueChanged)
        }
        
        let barButtonItem = UIBarButtonItem.init(customView: switchControl)
        return barButtonItem
    }
}
