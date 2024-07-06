//
//  MovieNetworkError.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import Foundation

enum MovieNetworkError: Error {
  case apiError
  case invalidEndpoint
  case invalidResponse
  case noData
  case serializationError

  var localizeDescription: String {
    switch self {
    case .apiError: return "Failed to fetch data"
    case .invalidEndpoint: return "Invalid endpoint"
    case .invalidResponse: return "Invalid response"
    case .noData: return "No data"
    case .serializationError: return "Failed to decode data"
    }
  }
}

extension MovieNetworkError: CustomNSError {
  var errorUserInfo: [String: Any] {
    return [NSLocalizedDescriptionKey: localizeDescription]
  }
}
