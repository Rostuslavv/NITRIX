//
//  FavoriteMovieTableViewCell.swift
//  NITRIX
//
//  Created by Rostyslav on 31.01.2024.
//

import Foundation
import UIKit

final class FavoritesCellView: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var onDelete: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureRecognized(_:)))
        self.contentView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func longPressGestureRecognized(_ sender: UILongPressGestureRecognizer) {
        guard sender.state == .began else { return }
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
        
        onDelete?()
    }
    
    private func cleanCell() {
        movieImage.image = nil
        titleLabel.text = ""
    }
    
    // Setup cell view with this data
    func configureCell(image: String, movieTitle: String, onDelete: @escaping () -> Void) {
        cleanCell()
        self.onDelete = onDelete
        titleLabel.text = movieTitle
        
        if let placeholderImage = UIImage(systemName: Constants.Views.MovieList.MovieCell.placeholderImage) {
            movieImage.getImage(sufixUrl: image, placeHolderImage: placeholderImage)
        } else {
            movieImage.getImage(sufixUrl: image)
        }
    }
}

