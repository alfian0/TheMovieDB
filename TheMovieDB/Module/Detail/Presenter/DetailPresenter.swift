//
//  DetailPresenter.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import Foundation
import Combine

class DetailPresenter: ObservableObject {
  private var usecase: DetailUseCase
  private var cancellables: Set<AnyCancellable> = []
  @Published var model: MovieModel
  @Published var isLoading: Bool = true

  init(usecase: DetailUseCase, model: MovieModel) {
    self.usecase = usecase
    self.model = model
  }

  func getMovieDetail() {
    usecase.getMovieDetail(id: model.id)
      .subscribe(on: DispatchQueue.global(qos: .background))
      .receive(on: DispatchQueue.main)
      .sink { _ in

      } receiveValue: { [weak self] value in
        self?.model = value
        self?.isLoading = false
      }
      .store(in: &cancellables)
  }
}
