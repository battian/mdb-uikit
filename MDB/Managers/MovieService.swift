//
//  MovieService.swift
//  MDB
//
//  Created by Ana Battistini on 04/08/24.
//

import Foundation

class MovieService {
  let API_KEY = ""
  
  static let shared = MovieService()
  
  private init() {}
  
  func fetchPopularMovies() async -> Result<[Movie], Error> {
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(API_KEY)") else {
      return .failure(URLError(.badURL))
    }
    
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
      return .success(moviesResponse.results)
    } catch {
      return .failure(error)
    }
  }
  
  func fetchMovieDetails(with movieId: Int) async -> Result<MovieDetails, Error> {
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(API_KEY)") else {
      return .failure(URLError(.badURL))
    }
    
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      let movieResponse = try JSONDecoder().decode(MovieDetails.self, from: data)
      return .success(movieResponse)
    } catch {
      return .failure(error)
    }
  }
}
