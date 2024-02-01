//
//  FavoritesViewLocalDataManager.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation
import CoreData

// MARK: - protocol FavoritesViewLocalDataManagerInputProtocol
protocol FavoritesViewLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
    
    func getFavorites(
        success: @escaping (([Movie]) -> ()),
        failure: @escaping ((CoreDataErrors) -> ()))
}


// MARK: - FavoritesViewLocalDataManager
final class FavoritesViewLocalDataManager {
    
    private var fetchRequest: NSFetchRequest<CDFavorite> = CDFavorite.fetchRequest()
    private var searchResults: Array<CDFavorite> = []
    private var managedObjectContext: NSManagedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
    
    private func mapSearchResultsToMovies(searchResults: [CDFavorite]) -> [Movie] {
        searchResults.compactMap {
            guard let id = Int(exactly: $0.id) else { return nil }
            let image = $0.image ?? "No image"
            let synopsis = $0.synopsis ?? "No synopsis"
            let title = $0.title ?? "No title"
            let favorite = true
            
            return Movie(
                movieID: id,
                title: title,
                synopsis: synopsis,
                image: image,
                favorite: favorite)
        }
    }
}


// MARK: - FavoritesViewLocalDataManagerInputProtocol
extension FavoritesViewLocalDataManager: FavoritesViewLocalDataManagerInputProtocol {
    
    func getFavorites(
        success: @escaping (([Movie]) -> ()),
        failure: @escaping ((CoreDataErrors) -> ())) {
            do {
                searchResults = try managedObjectContext.fetch(fetchRequest)
                let favorites = mapSearchResultsToMovies(searchResults: searchResults)
                success(favorites)
            } catch let error {
                print("\(Constants.Strings.errorLiteral): \(error.localizedDescription)")
                failure(.fetchingRequest)
            }
        }
}
