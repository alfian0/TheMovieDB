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
  private var cancellables: Set<AnyCancellable> = []
  @Published var searchText: String = ""
  @Published var movies: [MovieModel] = []

  init(usecase: SearchUseCase) {
    self.usecase = usecase

    $searchText
      .filter({ $0.count > 3 || $0.isEmpty })
      .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
      .flatMap(usecase.searchMovies)
      .subscribe(on: DispatchQueue.global(qos: .background))
      .receive(on: DispatchQueue.main)
      .sink { _ in

      } receiveValue: { [weak self] value in
        self?.movies = value
      }
      .store(in: &cancellables)
  }

  func go(to page: HomeRouter) -> some View {
    return page.view
  }
}
