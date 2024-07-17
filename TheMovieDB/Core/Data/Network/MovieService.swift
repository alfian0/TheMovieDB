//
//  MovieService.swift
//  TheMovieDB
//
//  Created by alfian on 04/07/24.
//

import Foundation
import Combine
import TheMovieDBCore

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
      .publisher(request: APIRouter.Movies(endpoint: endpoint).asURLRequest(baseURL: APIConstans.baseURL)!)
      .tryMap(DefaultDTOMapper.map)
      .eraseToAnyPublisher()
  }

  func fetchMovieDetail(id: Int) -> AnyPublisher<APIRouter.MovieDetail.ReturnType, Error> {
    client
      .publisher(request: APIRouter.MovieDetail(id: id).asURLRequest(baseURL: APIConstans.baseURL)!)
      .tryMap(DefaultDTOMapper.map)
      .eraseToAnyPublisher()
  }

  func searchMovies(with query: String) -> AnyPublisher<APIRouter.Movies.ReturnType, Error> {
    client
      .publisher(request: APIRouter.SearchMovies(query: query).asURLRequest(baseURL: APIConstans.baseURL)!)
      .tryMap(DefaultDTOMapper.map)
      .eraseToAnyPublisher()
  }
}
