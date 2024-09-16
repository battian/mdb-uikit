//
//  HomeViewController.swift
//  MDB
//
//  Created by Ana Battistini on 02/08/24.
//

import UIKit

class HomeViewController: UIViewController {
  
  private var movies: [Movie] = []
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Trending 🔥"
    label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    label.textColor = .label
    label.textAlignment = .left
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureCollectionView()
    configureUI()
    loadPopularMovies()
  }
  
  func configureCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 15, left: 8, bottom: 16, right: 8)
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .systemBackground
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func configureUI() {
    view.backgroundColor = .systemBackground
    
    view.addSubview(titleLabel)
    view.addSubview(collectionView)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      
      collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  func loadPopularMovies() {
    Task {
      let result = await MovieService.shared.fetchPopularMovies()
      
      switch result {
      case .success(let movies):
        self.movies = movies
        
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
      case .failure(let error):
        print("Failed to fetch movies: \(error)")
      }
    }
  }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell
    else { return UICollectionViewCell() }
    
    let movie = movies[indexPath.item]
    cell.configure(with: movie)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let padding: CGFloat = 10
    let availableWidth = collectionView.frame.width - (padding * 4)
    let width = availableWidth / 3
    return CGSize(width: width, height: 180)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedMovie = movies[indexPath.item]
    let movieViewController = MovieViewController()
    movieViewController.movieId = selectedMovie.id
    navigationController?.pushViewController(movieViewController, animated: true)
  }
}

