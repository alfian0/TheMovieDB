//
//  AllListPresenter.swift
//  TheMovieDB
//
//  Created by alfian on 23/07/24.
//

import Foundation

final class AllListPresenter: ObservableObject {
  @Published var movies: [MovieModel]
  private var coordinator: AllListCoordinator

  init(movies: [MovieModel], coordinator: AllListCoordinator) {
    self.movies = movies
    self.coordinator = coordinator
  }

  func goToDetail(with model: MovieModel) {
    self.coordinator.goToDetail(with: model)
  }
}
