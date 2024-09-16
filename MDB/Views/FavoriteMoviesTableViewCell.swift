//
//  FavoriteMoviesTableViewCell.swift
//  MDB
//
//  Created by Ana Battistini on 12/08/24.
//

import UIKit

class FavoriteMoviesTableViewCell: UITableViewCell {
  
  static let identifier = "FavoriteMoviesCell"
  
  private let posterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "poster-placeholder")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 8
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    label.textColor = .label
    label.textAlignment = .left
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let dateLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    label.textColor = .secondaryLabel
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let textStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .leading
    stackView.spacing = 4
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    contentView.addSubview(posterImageView)
    contentView.addSubview(textStackView)
    
    textStackView.addArrangedSubview(titleLabel)
    textStackView.addArrangedSubview(dateLabel)
    
    NSLayoutConstraint.activate([
      posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      posterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      posterImageView.widthAnchor.constraint(equalToConstant: 80),
      posterImageView.heightAnchor.constraint(equalToConstant: 120),
      
      textStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
      textStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])
  }
  
  func configure(with movie: FavoriteMovie) {
    titleLabel.text = movie.title
    dateLabel.text = String(movie.releaseDate.prefix(4))
    
    if let posterPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
      posterImageView.loadImage(from: url)
    } else {
      posterImageView.image = UIImage(named: "poster-placeholder")
    }
  }
}

