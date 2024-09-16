//
//  Movie.swift
//  MDB
//
//  Created by Ana Battistini on 04/08/24.
//

import Foundation

struct Movie: Codable {
  let id: Int
  let title: String
  let posterPath: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case posterPath = "poster_path"
  }
}

struct MoviesResponse: Codable {
  let results: [Movie]
}
