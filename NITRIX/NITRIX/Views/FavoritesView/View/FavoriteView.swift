//
//  MovieCell.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation
import UIKit


// MARK: - protocol FavoritesViewProtocol
protocol FavoritesViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: FavoritesViewPresenterProtocol? { get set }
    
    // Check if a movie has been stored as a favorite
    func refreshData(favorites: [Movie])
    
    // Setup interface
    func setupUI(withTitle: String)
    
    // Enable flag. Task begins
    func startActivity()
    
    // Disable flag. Task finished
    func stopActivity()
}


// MARK: - FavoritesView
final class FavoritesView: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    var presenter: FavoritesViewPresenterProtocol?
    
    private var favorites = [Movie]()
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }
    
    
    // MARK: Private methods
    
    private func registerCell() {
        let cellNib = UINib(nibName: Constants.Views.Favorites.FavoritesCell.nibName, bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: Constants.Views.Favorites.FavoritesCell.cellID)
    }
    
    private func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}


// MARK: - FavoritesViewProtocol
extension FavoritesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let favorites = presenter?.favoritesData ?? []
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let favorites = presenter?.favoritesData ?? []
        let item = favorites[row]
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Views.Favorites.FavoritesCell.cellID) as? FavoritesCellView else { return UITableViewCell() }
        cell.configureCell(
            image: item.image,
            movieTitle: item.title, onDelete: { [weak self] in
                self?.alert(style: .actionSheet, actions: [
                    UIAlertAction(title: "Delete", style: .destructive, handler: { [weak  self] (cell) in
                        self?.presenter?.removeFavorite(movie: item)
                    }),
                    UIAlertAction(title: "Cancel", style: .default),
                ])
            })
        
        return cell
    }
    
    func alert(_ title: String? = nil, message: String? = nil, style: UIAlertController.Style, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach(alertController.addAction)
        present(alertController, animated: true)
    }
}


// MARK: - FavoritesViewProtocol
extension FavoritesView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let item = favorites[row]
        let movieID = item.movieID
        
        presenter?.goToDetailView(movieID: movieID)
    }
    
}


// MARK: - FavoritesViewProtocol
extension FavoritesView: FavoritesViewProtocol {
    
    func refreshData(favorites: [Movie]) {
        self.favorites = favorites
        reloadTable()
    }
    
    func setupUI(withTitle: String) {
        self.title = withTitle
    }
    
    func startActivity() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopActivity() {
        DispatchQueue.main.async {
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.stopAnimating()
        }
    }
}

extension FavoritesView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

