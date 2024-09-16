//
//  FavoriteMovie.swift
//  MDB
//
//  Created by Ana Battistini on 12/08/24.
//

import Foundation

struct FavoriteMovie: Codable {
  let id: Int
  let title: String
  let posterPath: String?
  let releaseDate: String
}
