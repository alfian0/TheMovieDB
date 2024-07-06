//
//  HomePresenter.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import Foundation
import Combine
import SwiftUI

class HomePresenter: ObservableObject {
  @Injected private var usecase: HomeUseCase
  private var cancellables: Set<AnyCancellable> = []
  @Published var nowPlayingMovies: [MovieModel] = []
  @Published var topRatedMovies: [MovieModel] = []
  @Published var upcomingMovies: [MovieModel] = []

//  init(usecase: HomeUseCase = HomeInteractor()) {
//    self.usecase = usecase
//  }

  func getNowPlayingMovies() {
    usecase.getNowPlayingMovies()
      .receive(on: DispatchQueue.main)
      .sink { _ in

      } receiveValue: { [weak self] value in
        self?.nowPlayingMovies = value
      }
      .store(in: &cancellables)
  }

  func getToRatedMovies() {
    usecase.getTopRatedMovies()
      .receive(on: DispatchQueue.main)
      .sink { _ in

      } receiveValue: { [weak self] value in
        self?.topRatedMovies = value
      }
      .store(in: &cancellables)
  }

  func getUpcomingMovies() {
    usecase.getUpcomingMovies()
      .receive(on: DispatchQueue.main)
      .sink { _ in

      } receiveValue: { [weak self] value in
        self?.upcomingMovies = value
      }
      .store(in: &cancellables)
  }

  func go(to page: HomeRouter) -> some View {
    return page.view
  }
}
