//
//  FavoritesMoviesViewController.swift
//  MDB
//
//  Created by Ana Battistini on 02/08/24.
//

import UIKit

protocol FavoritesMoviesViewControllerDelegate: AnyObject {
  func favoritesDidUpdate()
}

class FavoritesMoviesViewController: UIViewController {
  
  private var favorites: [FavoriteMovie] = []
  private let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    favoritesDidUpdate()
  }
  
  private func configureUI() {
    view.addSubview(tableView)
    view.backgroundColor = .systemBackground
    tableView.backgroundColor = .systemBackground
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(FavoriteMoviesTableViewCell.self, forCellReuseIdentifier: FavoriteMoviesTableViewCell.identifier)
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 16),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
    ])
  }
  
  private func getFavorites() {
    favorites = loadFavoriteMovies()
  }
}

extension FavoritesMoviesViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favorites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMoviesTableViewCell.identifier, for: indexPath) as? FavoriteMoviesTableViewCell else { return UITableViewCell() }
    
    cell.backgroundColor = .clear
    tableView.separatorStyle = .none
    let movie = favorites[indexPath.row]
    cell.configure(with: movie)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedMovie = favorites[indexPath.item]
    let movieViewController = MovieViewController()
    movieViewController.movieId = selectedMovie.id
    navigationController?.pushViewController(movieViewController, animated: true)
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension FavoritesMoviesViewController: FavoritesMoviesViewControllerDelegate {
  func favoritesDidUpdate() {
    getFavorites()
    self.tableView.reloadData()
  }
}
