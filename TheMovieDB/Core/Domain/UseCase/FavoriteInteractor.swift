//
//  FavoriteInteractor.swift
//  TheMovieDB
//
//  Created by alfian on 10/07/24.
//

import Foundation
import Combine

protocol FavoriteUseCase {
  func getFavorites() -> AnyPublisher<[MovieModel], Error>
}

class FavoriteInteractor: FavoriteUseCase {
  private var repository: MovieRepository

  init(repository: MovieRepository) {
    self.repository = repository
  }

  func getFavorites() -> AnyPublisher<[MovieModel], Error> {
    self.repository.getFavorites()
      .tryMap(MovieModelMapper.mapFavoriteEntitiesToEntities)
      .eraseToAnyPublisher()
  }
}