//
//  NetworkingManager.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation

// MARK: - StringExtension
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
