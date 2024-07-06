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
}

class MovieRepositoryImpl: MovieRepository {
  @Injected private var movieService: MovieService

// MARK: We dont need this because we use Dependency Container Wrapper
//  init(movieService: MovieService = MovieServiceImpl()) {
//    self.movieService = movieService
//  }

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
}
