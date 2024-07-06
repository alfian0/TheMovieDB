//
//  DetailPresenter.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import Foundation
import Combine

class DetailPresenter: ObservableObject {
  @Injected private var usecase: DetailUseCase
  private var cancellables: Set<AnyCancellable> = []
  @Published var model: MovieModel

//  init(usecase: DetailUseCase = DetailInteractor(), model: MovieModel) {
//    self.usecase = usecase
//    self.model = model
//  }

  init(model: MovieModel) {
    self.model = model
  }

  func getMovieDetail() {
    usecase.getMovieDetail(id: model.id)
      .receive(on: DispatchQueue.main)
      .sink { _ in

      } receiveValue: { [weak self] value in
        self?.model = value
      }
      .store(in: &cancellables)
  }
}
