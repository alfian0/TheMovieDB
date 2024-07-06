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
}

class MovieServiceImpl: MovieService {
// MARK: Because we use swinject we dont need use initialize to init client
//  private let client: HTTPClient
//
//  init(client: HTTPClient = AlamofireAuthenticatedClient()) {
//    self.client = client
//  }

// MARK: Because we use propertywrapper Injected we dont need to write all of this
//  private let client: HTTPClient = Injection.shared.container.resolve(HTTPClient.self)!

  @Injected private var client: HTTPClient

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
}
