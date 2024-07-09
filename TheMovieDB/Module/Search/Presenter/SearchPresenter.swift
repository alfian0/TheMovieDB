//
//  SearchPresenter.swift
//  TheMovieDB
//
//  Created by alfian on 06/07/24.
//

import Foundation
import SwiftUI
import Combine

final class SearchPresenter: ObservableObject {
  private var usecase: SearchUseCase
  private var coordinator: SearchCoordinator
  private var cancellables: Set<AnyCancellable> = []
  @Published var searchText: String = ""
  @Published var movies: [MovieModel] = []

  init(usecase: SearchUseCase, coordinator: SearchCoordinator) {
    self.usecase = usecase
    self.coordinator = coordinator

    $searchText
      .filter({ $0.count > 3 || $0.isEmpty })
      .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
      .setFailureType(to: Error.self)
      .flatMap(usecase.searchMovies)
      .subscribe(on: DispatchQueue.global(qos: .background))
      .receive(on: DispatchQueue.main)
      .sink { _ in

      } receiveValue: { [weak self] value in
        self?.movies = value
      }
      .store(in: &cancellables)
  }

  deinit {
    self.cancellables.forEach { cancellable in
      cancellable.cancel()
    }
  }

  func goToDetail(with model: MovieModel) {
    coordinator.goToDetail(with: model)
  }
}
