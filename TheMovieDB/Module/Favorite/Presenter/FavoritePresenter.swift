//
//  FavoritePresenter.swift
//  TheMovieDB
//
//  Created by alfian on 10/07/24.
//

import Foundation
import Combine

final class FavoritePresenter: ObservableObject {
  private var usecase: FavoriteUseCase
  private var coordinator: FavoriteCoordinator
  private var cancellables: Set<AnyCancellable> = []
  @Published var movies: [MovieModel] = []

  init(usecase: FavoriteUseCase, coordinator: FavoriteCoordinator) {
    self.usecase = usecase
    self.coordinator = coordinator
  }

  deinit {
    self.cancellables.forEach { cancellable in
      cancellable.cancel()
    }
  }

  func getFavoriteMovies() {
    self.usecase.getFavorites()
      .subscribe(on: DispatchQueue.global(qos: .background))
      .receive(on: DispatchQueue.main)
      .sink { _ in

      } receiveValue: { [weak self] movies in
        self?.movies = movies
      }
      .store(in: &cancellables)
  }

  func deleteFavoriteMovie(index: Int) {
    let id = movies[index].id
    self.usecase.deleteFavorite(id: id)
      .subscribe(on: DispatchQueue.global(qos: .background))
      .receive(on: DispatchQueue.main)
      .sink { _ in

      } receiveValue: { _ in

      }
      .store(in: &cancellables)
  }
}
