//
//  JSONRepository.swift
//  TheMovieDB
//
//  Created by alfian on 06/07/24.
//

import Foundation
import Combine

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
}
