//
//  MoviesListViewController.swift
//  NITRIX
//
//  Created by Rostyslav on 29.01.2024.
//

import UIKit
import Alamofire

// MARK: - MovieListCellView
final class MovieCellView: UITableViewCell {
    
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var synopsisTagLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTagLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func cleanCell() {
        movieImage.image = nil
        titleLabel.text = ""
        synopsisLabel.text = ""
    }
    
    // Setup cell view with this data
    func configureCell(movieTitle: String, movieSynopsis: String, image: String) {
        cleanCell()
        
        titleLabel.text = movieTitle
        synopsisLabel.text = movieSynopsis
        
        if let placeholderImage = UIImage(systemName: Constants.Views.MovieList.MovieCell.placeholderImage) {
            movieImage.getImage(sufixUrl: image, placeHolderImage: placeholderImage)
        } else {
            movieImage.getImage(sufixUrl: image)
        }
    }
}
