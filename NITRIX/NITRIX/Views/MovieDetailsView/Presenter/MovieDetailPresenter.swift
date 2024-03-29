//
//  MovieDetailPresenter.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation

// MARK: - protocol MovieDetailPresenterProtocol
protocol MovieDetailPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    
    var view: MovieDetailViewProtocol? { get set }
    var interactor: MovieDetailInteractorInputProtocol? { get set }
    var wireFrame: MovieDetailWireFrameProtocol? { get set }
    
    var movieID: Int? { get set }
    
    // Add or remove movie locally
    func addOrRemoveFavorite(state: Bool)
    
    // View lifecylcle
    func viewDidLoad()
    
    // View lifecylcle
    func viewWillAppear()
}


// MARK: - protocol MovieDetailInteractorOutputProtocol
protocol MovieDetailInteractorOutputProtocol: AnyObject { }

// MARK: - MovieDetailPresenter
final class MovieDetailPresenter  {
    
    // MARK: Properties
    weak var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorInputProtocol?
    var wireFrame: MovieDetailWireFrameProtocol?
    
    var movieID: Int?
    
    private var movieDetail: MovieDetail?
    
    private func getMovieDetail(movieID: Int) {
        view?.startActivity()
        interactor?.getMovie(movieID: movieID, success: { [weak self] movieDetail in
            self?.movieDetail = movieDetail
            self?.view?.setupMovie(movieDetail: movieDetail)
            self?.view?.stopActivity()
        }, failure: { [weak self] networkError in
            self?.view?.stopActivity()
            print("\(Constants.Strings.errorLiteral): \(networkError.localizedDescription)")
        })
    }
    
}


// MARK: - MovieDetailPresenterProtocol
extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    func addOrRemoveFavorite(state: Bool) {
        guard let movieDetail = movieDetail else { return }
        
        interactor?.addOrRemoveFavorite(
            state: state,
            movieDetail: movieDetail,
            success: { [weak self] in
                if let movieID = self?.movieID {
                    self?.getMovieDetail(movieID: movieID)
                }
            }, failure: { [weak self] coreDataError in
                if let movieID = self?.movieID {
                    self?.getMovieDetail(movieID: movieID)
                }
            })
    }
    
    func viewDidLoad() {
        view?.setupUI(withTitle: Constants.Views.MovieDetail.title)
        guard let movieID = movieID else { return }
        
        getMovieDetail(movieID: movieID)
    }
    
    func viewWillAppear() {
        guard let movieID = movieID else { return }
        getMovieDetail(movieID: movieID)
    }
    
}


// MARK: - MovieDetailInteractorOutputProtocol
extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol { }
