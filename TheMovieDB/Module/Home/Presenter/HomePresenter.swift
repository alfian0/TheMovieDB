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
  private var usecase: HomeUseCase
  private var cancellables: Set<AnyCancellable> = []
  @Published var nowPlayingMovies: [MovieModel] = []
  @Published var topRatedMovies: [MovieModel] = []
  @Published var upcomingMovies: [MovieModel] = []
  @Published var isLoading: Bool = true
  @Published var isError: Bool = false
  @Published var errorMessage: String?
  private var nowPlayingIsLoading: Bool = true
  private var topRatedIsLoading: Bool = true
  private var upComingIsLoading: Bool = true

  init(usecase: HomeUseCase) {
    self.usecase = usecase
  }

  func getNowPlayingMovies() {
    usecase.getNowPlayingMovies()
      .subscribe(on: DispatchQueue.global(qos: .background))
      .receive(on: DispatchQueue.main)
      .sink { completion in
        if case let .failure(error) = completion {
          self.isError = true
          self.isLoading = false
          self.errorMessage = error.localizedDescription
        }
      } receiveValue: { [weak self] value in
        guard let `self` = self else { return }
        self.nowPlayingMovies = value
        self.nowPlayingIsLoading = false
        self.isLoading = self.nowPlayingIsLoading && self.topRatedIsLoading && self.upComingIsLoading
      }
      .store(in: &cancellables)
  }

  func getToRatedMovies() {
    usecase.getTopRatedMovies()
      .subscribe(on: DispatchQueue.global(qos: .background))
      .receive(on: DispatchQueue.main)
      .sink { completion in
        if case let .failure(error) = completion {
          self.isError = true
          self.isLoading = false
          self.errorMessage = error.localizedDescription
        }
      } receiveValue: { [weak self] value in
        guard let `self` = self else { return }
        self.topRatedMovies = value
        self.topRatedIsLoading = false
        self.isLoading = self.nowPlayingIsLoading && self.topRatedIsLoading && self.upComingIsLoading
      }
      .store(in: &cancellables)
  }

  func getUpcomingMovies() {
    usecase.getUpcomingMovies()
      .subscribe(on: DispatchQueue.global(qos: .background))
      .receive(on: DispatchQueue.main)
      .sink { completion in
        if case let .failure(error) = completion {
          self.isError = true
          self.isLoading = false
          self.errorMessage = error.localizedDescription
        }
      } receiveValue: { [weak self] value in
        guard let `self` = self else { return }
        self.upcomingMovies = value
        self.upComingIsLoading = false
        self.isLoading = self.nowPlayingIsLoading && self.topRatedIsLoading && self.upComingIsLoading
      }
      .store(in: &cancellables)
  }

  func go(to page: HomeRouter) -> some View {
    return page.view
  }
}
