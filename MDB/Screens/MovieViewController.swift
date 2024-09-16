//
//  MovieViewController.swift
//  MDB
//
//  Created by Ana Battistini on 02/08/24.
//

import UIKit

class MovieViewController: UIViewController {
  
  weak var delegate: FavoritesMoviesViewControllerDelegate?
  var movieId: Int?
  private var movie: MovieDetails?
  private var isFavorited = false
  
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  
  private let contentView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "poster-placeholder")
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = 8
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let movieTitleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.font = UIFont.systemFont(ofSize: 20)
    label.textAlignment = .center
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let detailsLabel: UILabel = {
    let label = UILabel()
    label.textColor = .secondaryLabel
    label.font = UIFont.systemFont(ofSize: 14)
    label.textAlignment = .center
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let ratingLabel: UILabel = {
    let label = UILabel()
    label.textColor = .systemGray
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()
  
  private let starIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "star.fill")
    imageView.tintColor = .systemYellow
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  private let ratingStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 4
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private let synopsisTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "Synopsis"
    label.textColor = .label
    label.font = UIFont.systemFont(ofSize: 18)
    label.textAlignment = .left
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let synopsisLabel: UILabel = {
    let label = UILabel()
    label.textColor = .secondaryLabel
    label.font = UIFont.systemFont(ofSize: 16)
    label.textAlignment = .left
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    isFavoritedCheck()
    configureUI()
    loadMovie()
  }
  
  private func isFavoritedCheck() {
    guard let movieId = movieId else { return }
    isFavorited = checkIfFavorited(movieId)
    configureNavigationBar()
  }
  
  private func configureNavigationBar() {
    let heartImage = isFavorited ? "heart.fill" : "heart"
    let rightBarButton = UIBarButtonItem(
      image: UIImage(systemName: heartImage),
      style: .plain,
      target: self,
      action: #selector(addToFavoritesButtonTapped)
    )
    navigationItem.rightBarButtonItem = rightBarButton
    navigationItem.rightBarButtonItem?.tintColor = .systemRed
  }
  
  private func configureUI() {
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    
    contentView.addSubview(imageView)
    contentView.addSubview(movieTitleLabel)
    contentView.addSubview(detailsLabel)
    contentView.addSubview(ratingStackView)
    contentView.addSubview(synopsisTitleLabel)
    contentView.addSubview(synopsisLabel)
    
    ratingStackView.addArrangedSubview(starIcon)
    ratingStackView.addArrangedSubview(ratingLabel)
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
      imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      imageView.heightAnchor.constraint(equalToConstant: 240),
      imageView.widthAnchor.constraint(equalToConstant: 160),
      
      movieTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
      movieTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      detailsLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 8),
      detailsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      detailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      ratingStackView.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 8),
      ratingStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      
      synopsisTitleLabel.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 24),
      synopsisTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      synopsisTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      synopsisLabel.topAnchor.constraint(equalTo: synopsisTitleLabel.bottomAnchor, constant: 8),
      synopsisLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      synopsisLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      synopsisLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
    ])
  }
  
  private func loadMovie() {
    Task {
      guard let movieId = movieId else { return }
      
      let result = await MovieService.shared.fetchMovieDetails(with: movieId)
      
      switch result {
      case .success(let movie):
        self.movie = movie
        let details = formatDetails(genres: movie.genres, releaseDate: movie.releaseDate, runtime: movie.runtime)
        let formattedVoteAverage = String(format: "%.1f", movie.voteAverage)
       
        DispatchQueue.main.async {
          self.movieTitleLabel.text = movie.title
          self.detailsLabel.text = details
          self.ratingLabel.text = "\(formattedVoteAverage)"
          self.synopsisLabel.text = movie.overview
          
          if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)") {
            self.imageView.loadImage(from: url)
          }
        }
      case .failure(let error):
        print("Failed to fetch movie: \(error)")
      }
    }
  }
  
  private func formatDetails(genres: [Genre], releaseDate: String, runtime: Int) -> String {
    let genreNames = genres.map { $0.name }
    let firstTwoGenres = genreNames.count > 1 ? genreNames.prefix(2) : genreNames.prefix(1)
    let genresString = firstTwoGenres.joined(separator: ", ")
    let year = String(releaseDate.prefix(4))
    
    return "\(genresString) • \(year) • \(runtime)min"
  }
  
  @objc private func addToFavoritesButtonTapped() {
    guard let movie = movie else { return }
    
    if isFavorited {
      if let error = removeFavoriteMovie(movie.id) {
        print("Failed to remove favorite: \(error)")
      } else {
        isFavorited = false
      }
    } else {
      if let error = addFavoriteMovie(
        FavoriteMovie(
          id: movie.id,
          title: movie.title,
          posterPath: movie.posterPath,
          releaseDate: movie.releaseDate
        )
      ) {
        print("Failed to add favorite: \(error)")
      } else {
        isFavorited = true
      }
    }
    
    let newImageName = isFavorited ? "heart.fill" : "heart"
    navigationItem.rightBarButtonItem?.image = UIImage(systemName: newImageName)
    
    delegate?.favoritesDidUpdate()
  }
}
