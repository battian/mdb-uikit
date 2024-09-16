//
//  MovieCollectionViewCell.swift
//  MDB
//
//  Created by Ana Battistini on 04/08/24.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
  static let identifier = "MovieCollectionViewCell"
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "poster-placeholder")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 8
    return imageView
  }()
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.imageView.image = nil
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    contentView.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.heightAnchor.constraint(equalToConstant: 180),
    ])
  }
  
  func configure(with movie: Movie) {
    if let posterPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
      imageView.loadImage(from: url)
    } else {
      imageView.image = UIImage(named: "poster-placeholder")
    }
  }
}
