//
//  MovieDetails.swift
//  MDB
//
//  Created by Ana Battistini on 09/08/24.
//

import Foundation

struct Genre: Codable {
  let name: String
}

struct MovieDetails: Codable {
  let id: Int
  var title: String
  let posterPath: String
  let overview: String
  let releaseDate: String
  let runtime: Int
  let voteAverage: Float
  let genres: [Genre]
  
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case overview
    case runtime
    case genres
    case posterPath = "poster_path"
    case releaseDate = "release_date"
    case voteAverage = "vote_average"
  }
}
