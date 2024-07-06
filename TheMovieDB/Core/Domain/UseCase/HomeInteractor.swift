//
//  HomeInteractor.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import Foundation
import Combine

protocol HomeUseCase {
  func getNowPlayingMovies() -> AnyPublisher<[MovieModel], Error>
  func getTopRatedMovies() -> AnyPublisher<[MovieModel], Error>
  func getUpcomingMovies() -> AnyPublisher<[MovieModel], Error>
}

class HomeInteractor: HomeUseCase {
  private var repository: MovieRepository

  init(repository: MovieRepository) {
    self.repository = repository
  }

  func getNowPlayingMovies() -> AnyPublisher<[MovieModel], Error> {
    return repository.getNowPlayingMovies()
      .tryMap(MovieModelMapper.mapMovieResponsesToEntities)
      .eraseToAnyPublisher()
  }

  func getTopRatedMovies() -> AnyPublisher<[MovieModel], Error> {
    return repository.getTopRatedMovies()
      .tryMap(MovieModelMapper.mapMovieResponsesToEntities)
      .eraseToAnyPublisher()
  }

  func getUpcomingMovies() -> AnyPublisher<[MovieModel], Error> {
    return repository.getUpcomingMovies()
      .tryMap(MovieModelMapper.mapMovieResponsesToEntities)
      .eraseToAnyPublisher()
  }
}
