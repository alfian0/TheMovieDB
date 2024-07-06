//
//  Injection.swift
//  TheMovieDB
//
//  Created by alfian on 06/07/24.
//

import Foundation
import Swinject

final class Injection {
  static let shared: Injection = Injection()

  var container: Container {
    get {
      if _container == nil {
        _container = buildContainer()
      }

      return _container!
    }
    set {
      _container = newValue
    }
  }

  private var _container: Container?

  private func buildContainer() -> Container {
    let container = Container()

    container.register(HTTPClient.self) { _ in
      // MARK: Because we use clean architecture we can change Client to use URLSession or Alamofire
//      return AlamofireAuthenticatedClient()
      return AuthenticatedHTTPClient()
    }

    container.register(MovieService.self) { _ in
      return MovieServiceImpl()
    }

    container.register(MovieRepository.self) { _ in
//      return JSONRepository()
      return MovieRepositoryImpl()
    }

    // MARK: Home
    // To do: Next we need use child container
    container.register(HomeUseCase.self) { _ in
      return HomeInteractor()
    }

    container.register(HomePresenter.self) { _ in
      return HomePresenter()
    }

    // MARK: Detail
    // To do: Next we need use child container
    container.register(DetailUseCase.self) { _ in
      return DetailInteractor()
    }

    container.register(DetailPresenter.self) { _, model in
      return DetailPresenter(model: model)
    }

    return container
  }
}
