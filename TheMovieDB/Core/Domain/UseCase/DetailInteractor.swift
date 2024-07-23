//
//  DetailInteractor.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import Foundation
import Combine
import TheMovieDBService

protocol DetailUseCase {
  func getMovieDetail(id: Int) -> AnyPublisher<MovieModel, Error>
}

class DetailInteractor: DetailUseCase {
  private var repository: MovieRepository

  init(repository: MovieRepository) {
    self.repository = repository
  }

  func getMovieDetail(id: Int) -> AnyPublisher<MovieModel, Error> {
    return repository.getMovieDetail(id: id)
      .tryMap(MovieModelMapper.mapMovieResponseToEntity)
      .eraseToAnyPublisher()
  }
}
