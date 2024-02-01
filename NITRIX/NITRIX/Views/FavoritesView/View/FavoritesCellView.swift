//
//  FavoriteMovieTableViewCell.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation
import UIKit

class FavoritesCellView: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func cleanCell() {
        movieImage.image = nil
        titleLabel.text = ""
    }
    
    // Setup cell view with this data
    func configureCell(image: String, movieTitle: String) {
        cleanCell()
        
        titleLabel.text = movieTitle
        
        if let placeholderImage = UIImage(systemName: Constants.Views.MovieList.MovieCell.placeholderImage) {
            movieImage.getImage(sufixUrl: image, placeHolderImage: placeholderImage)
        } else {
            movieImage.getImage(sufixUrl: image)
        }
    }
}
