//
//  MovieDetailFrame.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation
import UIKit

// MARK: protocol MovieDetailWireFrameProtocol
protocol MovieDetailWireFrameProtocol: AnyObject {
    static func createMovieDetailModule(movieID: Int) -> UIViewController
}


// MARK: MovieDetailWireFrame
final class MovieDetailWireFrame: MovieDetailWireFrameProtocol {
    
    private static var mainView: UIViewController {
        return MovieDetailView(nibName: Constants.Views.MovieDetail.nibName, bundle: Bundle.main)
    }
    
    class func createMovieDetailModule(movieID: Int) -> UIViewController {

        if let view = mainView as? MovieDetailView {
            let presenter: MovieDetailPresenterProtocol & MovieDetailInteractorOutputProtocol = MovieDetailPresenter()
            let interactor: MovieDetailInteractorInputProtocol & MovieDetailRemoteDataManagerOutputProtocol = MovieDetailInteractor()
            let localDataManager: MovieDetailLocalDataManagerInputProtocol = MovieDetailLocalDataManager()
            let remoteDataManager: MovieDetailRemoteDataManagerInputProtocol = MovieDetailRemoteDataManager()
            let wireFrame: MovieDetailWireFrameProtocol = MovieDetailWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            //remoteDataManager.remoteRequestHandler = interactor
            
            presenter.movieID = movieID
            
            return view
        }
        
        return UIViewController()
    }
}
