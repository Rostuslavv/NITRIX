//
//  Constants.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation

// MARK: - Constants
struct Constants {
    
    
    // MARK: API
    struct API {
        
        static let apiKeyParam = "?api_key="
        static let apiKeyValue = "2ccc9fcb3e886fcb5f80015418735095"
        static let moviesInitialPage = -1
        static let moviesFirstPage = 1
        static let moviesIncrementPage = 1
        static let moviesPageLimit = 500
        
        struct URL {
            static let urlMainSite = "https://api.themoviedb.org/"
            static let urlMainImagesW200 = "https://image.tmdb.org/t/p/w200/"
        }
        
        struct Endpoints {
            static let urlEndpointListMovies = "3/movie/popular"
            static let urlEndpointDetailMovie = "3/movie/"
        }
        
        struct Params {
            static let paramPage = "&page="
        }
    }
    
    
    // MARK: Managers
    struct Managers {
        
        struct CoreData {
            static let favoriteMovieEntityName = "CDFavorite"
            static let favoritesPersistentContainer = "MoviesCoreData"
        }
    }
    
    
    // MARK: Strings
    struct Strings {
        static let addFavoriteLiteral = "Add to favorite"
        static let deleteLiteral = "Strings_DeleteLiteral"
        static let errorLiteral = "Strings_ErrorLiteral"
        static let removeFavoriteLiteral = "Remove from favorite"
    }
    
    
    // MARK: Views
    struct Views {
        
        struct Favorites {
            static let nibName = "FavoritesView"
            static let placeholderImage = "film.circle"
            static let title = "Favorites"
            
            struct FavoritesCell {
                static let cellID = "FavoritesCellViewID"
                static let nibName = "FavoritesCellView"
                static let placeholderImage = "film.circle"
            }
        }
        
        struct Home {
            static let firstTabBarIcon = "film"
            static let secondTabBarIcon = "star"

            static let firstTabBarText = "Movies List"
            static let secondTabBarText = "Favorites"
        }
        
        struct MovieList {
            
            static let nibName = "MovieListView"
            static let searchBarPlaceholder = "Search"
            static let title = "Movies List"
            
            struct MovieCell {
                static let cellID = "MovieListCellViewID"
                static let nibName = "MovieCellView"
                static let placeholderImage = "film.circle"
            }
        }
        
        struct MovieDetail {
            static let mockID = "634649"
            static let nibName = "MovieDetailView"
            static let placeholderImage = "film.circle"
            static let title = "Favorites"
        }
    }
}
