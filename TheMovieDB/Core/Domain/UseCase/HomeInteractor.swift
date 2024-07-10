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
  func addFavorite(id: Int, title: String, overview: String) -> AnyPublisher<[MovieModel], Error>
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
    let movies = repository.getTopRatedMovies()
      .tryMap(MovieModelMapper.mapMovieResponsesToEntities)
    let favorites = repository.getFavorites()
    return Publishers.CombineLatest(movies, favorites)
      .map { (movies, favorites) in
        return movies.map { movie in
          var tempMovie = movie
          tempMovie.isFavorite = favorites.contains { $0.id == tempMovie.id }
          return tempMovie
        }
      }
      .eraseToAnyPublisher()
  }

  func getUpcomingMovies() -> AnyPublisher<[MovieModel], Error> {
    let movies = repository.getUpcomingMovies()
      .tryMap(MovieModelMapper.mapMovieResponsesToEntities)
    let favorites = repository.getFavorites()
    return Publishers.CombineLatest(movies, favorites)
      .map { (movies, favorites) in
        return movies.map { movie in
          var tempMovie = movie
          tempMovie.isFavorite = favorites.contains { $0.id == tempMovie.id }
          return tempMovie
        }
      }
      .eraseToAnyPublisher()
  }

  func addFavorite(id: Int, title: String, overview: String) -> AnyPublisher<[MovieModel], Error> {
    return repository.addFavorite(id: id, title: title, overview: overview)
      .tryMap(MovieModelMapper.mapFavoriteEntitiesToEntities)
      .eraseToAnyPublisher()
  }
}
