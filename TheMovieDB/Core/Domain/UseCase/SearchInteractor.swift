//
//  SearchInteractor.swift
//  TheMovieDB
//
//  Created by alfian on 06/07/24.
//

import Foundation
import Combine

protocol SearchUseCase {
  func searchMovies(with query: String) -> AnyPublisher<[MovieModel], Error>
}

class SearchInteractor: SearchUseCase {
  private var repository: MovieRepository

  init(repository: MovieRepository) {
    self.repository = repository
  }

  func searchMovies(with query: String) -> AnyPublisher<[MovieModel], Error> {
    return repository.searchMovies(with: query)
      .tryMap(MovieModelMapper.mapMovieResponsesToEntities)
      .eraseToAnyPublisher()
  }
}
