//
//  PersistenceManager.swift
//  MDB
//
//  Created by Ana Battistini on 11/08/24.
//

import Foundation

private let defaults = UserDefaults.standard
private let favoritesKey = "favorites"

func loadFavoriteMovies() -> [FavoriteMovie] {
  if let data = defaults.data(forKey: favoritesKey) {
    do {
      let movies = try JSONDecoder().decode([FavoriteMovie].self, from: data)
      return movies
    } catch {
      print("Failed to load favorite movies: \(error)")
    }
  }
  
  return []
}

func addFavoriteMovie(_ movie: FavoriteMovie) -> Error? {
  var favorites = loadFavoriteMovies()
  
  if !favorites.contains(where: { $0.id == movie.id }) {
    favorites.append(movie)
    
    do {
      let data = try JSONEncoder().encode(favorites)
      defaults.set(data, forKey: favoritesKey)
    } catch {
      return error
    }
  }
  
  return nil
}

func removeFavoriteMovie(_ id: Int) -> Error? {
  var favorites = loadFavoriteMovies()
  
  if let index = favorites.firstIndex(where: { $0.id == id }) {
    favorites.remove(at: index)
    
    do {
      let data = try JSONEncoder().encode(favorites)
      defaults.set(data, forKey: favoritesKey)
    } catch {
      return error
    }
  }
  
  return nil
}

func checkIfFavorited(_ id: Int) -> Bool {
  let favorites = loadFavoriteMovies()
  return favorites.contains { $0.id == id }
}
