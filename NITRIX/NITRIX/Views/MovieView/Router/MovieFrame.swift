//
//  MovieFrame.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation
import UIKit

// MARK: - protocol MovieListWireFrameProtocol
protocol MovieListWireFrameProtocol: AnyObject {
    // This is the WireFrame for MovieList screen
    static func createMovieListModule() -> UINavigationController
    // Here you can go to the screen that shows details of a movie
    func goToDetailView(view: MovieListViewProtocol, movieID: Int)
}


// MARK: - MovieListWireFrameProtocol
final class MovieListWireFrame: MovieListWireFrameProtocol {
    
    private static var mainView: UIViewController {
        return MovieListView(nibName: Constants.Views.MovieList.nibName, bundle: Bundle.main)
    }
    
    final class func createMovieListModule() -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: mainView)

        if let view = navController.children.first as? MovieListView {
            let presenter: MovieListPresenterProtocol & MovieListInteractorOutputProtocol = MovieListPresenter()
            let interactor: MovieListInteractorInputProtocol & MovieListLocalDataManagerOutputProtocol& MovieListMockDataManagerOutputProtocol& MovieListRemoteDataManagerOutputProtocol = MovieListInteractor()
            let localDataManager: MovieListLocalDataManagerInputProtocol = MovieListLocalDataManager()
            let mockDataManager: MovieListMockDataManagerInputProtocol = MovieListMockDataManager()
            let remoteDataManager: MovieListRemoteDataManagerInputProtocol = MovieListRemoteDataManager()
            let wireFrame: MovieListWireFrameProtocol = MovieListWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.mockDatamanager = mockDataManager
            interactor.remoteDatamanager = remoteDataManager
            //remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        
        return UINavigationController()
    }
    
    func goToDetailView(view: MovieListViewProtocol, movieID: Int) {
        guard let baseView = view as? UIViewController else { return }
        
        DispatchQueue.main.async {
            let vc = MovieDetailWireFrame.createMovieDetailModule(movieID: movieID)
            baseView.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
