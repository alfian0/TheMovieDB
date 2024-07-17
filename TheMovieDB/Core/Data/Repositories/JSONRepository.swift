//
//  JSONRepository.swift
//  TheMovieDB
//
//  Created by alfian on 06/07/24.
//

import Foundation
import Combine
import TheMovieDBCore

// MARK: For testing purpose when Backend not done yet
class JSONRepository: MovieRepository {
  func getNowPlayingMovies() -> AnyPublisher<[MovieDTO], Error> {
    return Just(StubDataLoader.loadStubMovies())
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }

  func getTopRatedMovies() -> AnyPublisher<[MovieDTO], Error> {
    return Just(StubDataLoader.loadStubMovies())
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }

  func getUpcomingMovies() -> AnyPublisher<[MovieDTO], Error> {
    return Just(StubDataLoader.loadStubMovies())
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }

  func getMovieDetail(id: Int) -> AnyPublisher<MovieDTO, Error> {
    return Just(StubDataLoader.loadStubMovie()!)
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }

  func searchMovies(with query: String) -> AnyPublisher<[MovieDTO], Error> {
    return Just(StubDataLoader.loadStubMovies())
      .setFailureType(to: Error.self)
      .eraseToAnyPublisher()
  }

  func getFavorites() -> AnyPublisher<[FavoriteEntity], Error> {
    return Fail(error: MovieNetworkError.apiError)
      .eraseToAnyPublisher()
  }

  func addFavorite(id: Int, title: String, overview: String) -> AnyPublisher<[FavoriteEntity], Error> {
    return Fail(error: MovieNetworkError.apiError)
      .eraseToAnyPublisher()
  }
}
