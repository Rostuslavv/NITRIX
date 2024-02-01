//
//  FavoritesViewInteractorInputProtocol.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation

// MARK: - protocol FavoritesViewInteractorInputProtocol
protocol FavoritesViewInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: FavoritesViewInteractorOutputProtocol? { get set }
    var localDatamanager: FavoritesViewLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: FavoritesViewRemoteDataManagerInputProtocol? { get set }
    func getFavorites(
        success: @escaping (([Movie]) -> ()),
        failure: @escaping ((CoreDataErrors) -> ()))
}


// MARK: - protocol FavoritesViewLocalDataManagerOutputProtocol
protocol FavoritesViewLocalDataManagerOutputProtocol: AnyObject { }


// MARK: - FavoritesViewRemoteDataManagerOutputProtocol
protocol FavoritesViewRemoteDataManagerOutputProtocol: AnyObject { }


// MARK: - FavoritesViewInteractorInputProtocol
final class FavoritesViewInteractor: FavoritesViewInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: FavoritesViewInteractorOutputProtocol?
    var localDatamanager: FavoritesViewLocalDataManagerInputProtocol?
    var remoteDatamanager: FavoritesViewRemoteDataManagerInputProtocol?
    
    func getFavorites(success: @escaping (([Movie]) -> ()), failure: @escaping ((CoreDataErrors) -> ())) {
        localDatamanager?.getFavorites(success: success, failure: failure)
    }
}


// MARK: - FavoritesViewLocalDataManagerOutputProtocol
extension FavoritesViewInteractor: FavoritesViewLocalDataManagerOutputProtocol { }
