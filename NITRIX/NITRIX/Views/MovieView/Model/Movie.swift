//
//  Movie.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    
    let movieID: Int
    let title: String
    let synopsis: String
    let image: String
    var favorite: Bool
    
    init(movieID: Int, title: String, synopsis: String, image: String, favorite: Bool = false) {
        self.movieID = movieID
        self.title = title
        self.synopsis = synopsis
        self.image = image
        self.favorite = favorite
    }
}
