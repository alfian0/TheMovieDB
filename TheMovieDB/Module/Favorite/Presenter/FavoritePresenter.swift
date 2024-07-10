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
      .sink { completion in
        
      } receiveValue: { [weak self] movies in
        self?.movies = movies
      }
      .store(in: &cancellables)
  }
}
