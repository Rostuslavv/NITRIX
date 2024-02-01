//
//  MovieDetail.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation

// MARK: - MovieDetail
struct MovieDetail: Codable {
    
    let movieID: Int
    
    let favorite: Bool
    let image: String
    let originalTitle: String
    let rating: String
    let releaseDate: String
    let synopsis: String
    let title: String
    
    init(movieID: Int, image: String, originalTitle: String, rating: String, releaseDate: String, synopsis: String, title: String, favorite: Bool) {
        self.movieID = movieID
        
        self.favorite = favorite
        self.image = image
        self.originalTitle = originalTitle
        self.rating = rating
        self.releaseDate = releaseDate
        self.synopsis = synopsis
        self.title = title
    }
}
