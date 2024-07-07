//
//  MovieService.swift
//  TheMovieDB
//
//  Created by alfian on 04/07/24.
//

import Foundation
import Combine

protocol MovieService {
  func fetchNowMovies(from endpoint: MovieListEndpoint) -> AnyPublisher<APIRouter.Movies.ReturnType, Error>
  func fetchMovieDetail(id: Int) -> AnyPublisher<APIRouter.MovieDetail.ReturnType, Error>
  func searchMovies(with query: String) -> AnyPublisher<APIRouter.Movies.ReturnType, Error>
}

class MovieServiceImpl: MovieService {
  private let client: HTTPClient

  init(client: HTTPClient) {
    self.client = client
  }

  func fetchNowMovies(from endpoint: MovieListEndpoint) -> AnyPublisher<APIRouter.Movies.ReturnType, Error> {
    client
      .publisher(request: APIRouter.Movies(endpoint: endpoint).asURLRequest()!)
      .tryMap(DefaultDTOMapper.map)
      .eraseToAnyPublisher()
  }

  func fetchMovieDetail(id: Int) -> AnyPublisher<APIRouter.MovieDetail.ReturnType, Error> {
    client
      .publisher(request: APIRouter.MovieDetail(id: id).asURLRequest()!)
      .tryMap(DefaultDTOMapper.map)
      .eraseToAnyPublisher()
  }

  func searchMovies(with query: String) -> AnyPublisher<APIRouter.Movies.ReturnType, Error> {
    client
      .publisher(request: APIRouter.SearchMovies(query: query).asURLRequest()!)
      .tryMap(DefaultDTOMapper.map)
      .eraseToAnyPublisher()
  }
}
