//
//  MovieRepository.swift
//  TheMovieDB
//
//  Created by alfian on 04/07/24.
//

import Foundation
import Combine

protocol MovieRepository {
  func getNowPlayingMovies() -> AnyPublisher<[MovieDTO], Error>
  func getTopRatedMovies() -> AnyPublisher<[MovieDTO], Error>
  func getUpcomingMovies() -> AnyPublisher<[MovieDTO], Error>
  func getMovieDetail(id: Int) -> AnyPublisher<MovieDTO, Error>
  func searchMovies(with query: String) -> AnyPublisher<[MovieDTO], Error>
  func getFavorites() -> AnyPublisher<[FavoriteEntity], Error>
  func addFavorite(id: Int, title: String, overview: String) -> AnyPublisher<[FavoriteEntity], Error>
  func deleteFavorite(id: Int) -> AnyPublisher<[FavoriteEntity], Error>
}

class MovieRepositoryImpl: MovieRepository {
  private var movieService: MovieService
  private var favoriteService: FavoriteService

  init(movieService: MovieService, favoriteService: FavoriteService) {
    self.movieService = movieService
    self.favoriteService = favoriteService
  }

  func getNowPlayingMovies() -> AnyPublisher<[MovieDTO], Error> {
    movieService.fetchNowMovies(from: .nowPlaying)
      .map({ $0.results })
      .eraseToAnyPublisher()
  }

  func getTopRatedMovies() -> AnyPublisher<[MovieDTO], Error> {
    movieService.fetchNowMovies(from: .topRated)
      .map({ $0.results })
      .eraseToAnyPublisher()
  }

  func getUpcomingMovies() -> AnyPublisher<[MovieDTO], Error> {
    movieService.fetchNowMovies(from: .upcoming)
      .map({ $0.results })
      .eraseToAnyPublisher()
  }

  func getMovieDetail(id: Int) -> AnyPublisher<MovieDTO, Error> {
    movieService.fetchMovieDetail(id: id)
      .eraseToAnyPublisher()
  }

  func searchMovies(with query: String) -> AnyPublisher<[MovieDTO], Error> {
    movieService.searchMovies(with: query)
      .map({ $0.results })
      .eraseToAnyPublisher()
  }

  func getFavorites() -> AnyPublisher<[FavoriteEntity], Error> {
    favoriteService.fetchFavorites()
  }

  func addFavorite(id: Int, title: String, overview: String) -> AnyPublisher<[FavoriteEntity], Error> {
    favoriteService.getFavorite(id: id)
      .filter({ $0.count == 0 })
      .flatMap { _ in
        return self.favoriteService.addFavorite(id: id, title: title, overview: overview)
      }
      .eraseToAnyPublisher()
  }

  func deleteFavorite(id: Int) -> AnyPublisher<[FavoriteEntity], Error> {
    favoriteService.deleteFavorite(id: id)
  }
}
