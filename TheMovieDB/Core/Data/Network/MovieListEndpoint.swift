//
//  MovieListEndpoint.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import Foundation

enum MovieListEndpoint: String {
  case nowPlaying = "now_playing"
  case upcoming
  case topRated = "top_rated"
  case popular

  var description: String {
    switch self {
    case .nowPlaying: return "Now Playing"
    case .upcoming: return "Upcoming"
    case .topRated: return "Top Rated"
    case .popular: return "Popular"
    }
  }
}
