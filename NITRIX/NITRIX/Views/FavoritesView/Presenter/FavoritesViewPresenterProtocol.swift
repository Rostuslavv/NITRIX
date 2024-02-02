//
//  FavoritesViewPresenterProtocol.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation

// MARK: - protocol FavoritesViewPresenterProtocol
protocol FavoritesViewPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    
    var view: FavoritesViewProtocol? { get set }
    var interactor: FavoritesViewInteractorInputProtocol? { get set }
    var wireFrame: FavoritesViewWireFrameProtocol? { get set }
    var favoritesData: [Movie] { get }
    func goToDetailView(movieID: Int)
    func removeFavorite(movie: Movie)
    func viewDidLoad()
    func viewWillAppear()
}


// MARK: - protocol FavoritesViewInteractorOutputProtocol
protocol FavoritesViewInteractorOutputProtocol: AnyObject { }


// MARK: - FavoritesViewPresenter
final class FavoritesViewPresenter {
    
    // MARK: Properties
    weak var view: FavoritesViewProtocol?
    var interactor: FavoritesViewInteractorInputProtocol?
    var wireFrame: FavoritesViewWireFrameProtocol?
    
    var favoritesData: [Movie] {
        return favorites
    }
    
    private var favorites: [Movie] = [] {
        didSet {
            favorites.sort { $0.title < $1.title }
        }
    }
    
    private func getFavorites() {
        self.view?.startActivity()
        DispatchQueue.global().async {
            self.interactor?.getFavorites(success: { favorites in
                self.favorites = favorites
                self.view?.refreshData(favorites: self.favorites)
                self.view?.stopActivity()
            }, failure: { coreDataError in
                print("\(Constants.Strings.errorLiteral): \(coreDataError.localizedDescription)")
                self.view?.stopActivity()
            })
        }
    }
}


// MARK: - FavoritesViewPresenterProtocol
extension FavoritesViewPresenter: FavoritesViewPresenterProtocol {
    func removeFavorite(movie: Movie) {
        interactor?.removeFavorite(movie: movie, success: { [weak self] in
            guard let self else { return }
            if let removeIndex = self.favorites.firstIndex(where: { $0.movieID == movie.movieID }) {
                favorites.remove(at: removeIndex)
                self.view?.refreshData(favorites: self.favorites)
            }
        }, failure: { coreDataError in
            print("\(Constants.Strings.errorLiteral): \(coreDataError)")
        })
        
    }
    
    func goToDetailView(movieID: Int) {
        guard let view = view else { return }
        
        wireFrame?.goToDetailView(view: view, movieID: movieID)
    }
    
    func viewDidLoad() {
        view?.setupUI(withTitle: Constants.Views.Favorites.title)
        self.getFavorites()
    }
    
    func viewWillAppear() {
        self.getFavorites()
    }
}


// MARK: - FavoritesViewInteractorOutputProtocol
extension FavoritesViewPresenter: FavoritesViewInteractorOutputProtocol { }
