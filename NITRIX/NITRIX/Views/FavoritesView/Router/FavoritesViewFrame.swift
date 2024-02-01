//
//  FavoritesViewFrame.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation
import UIKit

// MARK: - FavoritesViewWireFrameProtocol
protocol FavoritesViewWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    
    static func createFavoritesViewModule() -> UINavigationController
    func goToDetailView(view: FavoritesViewProtocol, movieID: Int)
}


// MARK: - FavoritesViewWireFrameProtocol
final class FavoritesViewWireFrame: FavoritesViewWireFrameProtocol {
    
    private static var mainView: UIViewController {
        return FavoritesView(
            nibName: Constants.Views.Favorites.nibName,
            bundle: Bundle.main)
    }
    
    final class func createFavoritesViewModule() -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: mainView)
        
        if let view = navController.children.first as? FavoritesView {
            let presenter: FavoritesViewPresenterProtocol & FavoritesViewInteractorOutputProtocol = FavoritesViewPresenter()
            let interactor: FavoritesViewInteractorInputProtocol & FavoritesViewLocalDataManagerOutputProtocol = FavoritesViewInteractor()
            let localDataManager: FavoritesViewLocalDataManagerInputProtocol = FavoritesViewLocalDataManager()
            let remoteDataManager: FavoritesViewRemoteDataManagerInputProtocol = FavoritesViewRemoteDataManager()
            let wireFrame: FavoritesViewWireFrameProtocol = FavoritesViewWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            
            return navController
        }
        
        return UINavigationController()
    }
    
    func goToDetailView(view: FavoritesViewProtocol, movieID: Int) {
        guard let baseView = view as? UIViewController else { return }
        
        DispatchQueue.main.async {
            let vc = MovieDetailWireFrame.createMovieDetailModule(movieID: movieID)
            baseView.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
