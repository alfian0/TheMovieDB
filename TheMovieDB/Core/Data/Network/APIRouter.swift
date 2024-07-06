//
//  APIRouter.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import Foundation

class APIRouter {
  struct MovieDetail: Request {
    typealias ReturnType = MovieDTO
    var path: String
    var queryParams: [String: Any]?

    init(id: Int) {
      self.path = "/movie/\(id)"
      self.queryParams = [
        "append_to_response": "casts,videos"
      ]
    }
  }

  struct Movies: Request {
    typealias ReturnType = ListDTO<MovieDTO>
    var path: String

    init(endpoint: MovieListEndpoint) {
      self.path = "/movie/\(endpoint.rawValue)"
    }
  }

  struct SearchMovies: Request {
    typealias ReturnType = ListDTO<MovieDTO>
    var path: String
    var queryParams: [String: Any]?

    init(query: String) {
      self.path = "/search/movie"
      self.queryParams = [
        "query": query
      ]
    }
  }
}
