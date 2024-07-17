//
//  FavoriteService.swift
//  TheMovieDB
//
//  Created by alfian on 10/07/24.
//

import Combine
import TheMovieDBCore

protocol FavoriteService {
  func fetchFavorites() -> AnyPublisher<[FavoriteEntity], Error>
  func getFavorite(id: Int) -> AnyPublisher<[FavoriteEntity], Error>
  func addFavorite(id: Int, title: String, overview: String) -> AnyPublisher<[FavoriteEntity], Error>
}

final class FavoriteServiceImp: FavoriteService {
  private let client: CoreDataClient

  init(with client: CoreDataClient) {
    self.client = client
  }

  func fetchFavorites() -> AnyPublisher<[FavoriteEntity], Error> {
    self.client.fetchRequest(FavoriteEntity.self)
  }

  func getFavorite(id: Int) -> AnyPublisher<[FavoriteEntity], Error> {
    self.client.fetchRequest(FavoriteEntity.self, predicate: ["id": id])
  }

  func addFavorite(id: Int, title: String, overview: String) -> AnyPublisher<[FavoriteEntity], Error> {
    self.client.add(FavoriteEntity.self) { context in
      let newFavorite = FavoriteEntity(context: context)
      newFavorite.id = Int32(id)
      newFavorite.title = title
      newFavorite.overview = overview
    }
  }
}
