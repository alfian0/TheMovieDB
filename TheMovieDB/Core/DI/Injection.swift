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

    container.register(MovieService.self) { resolver in
      return MovieServiceImpl(client: resolver.resolve(HTTPClient.self)!)
    }

    container.register(MovieRepository.self) { resolver in
//      return JSONRepository()
      return MovieRepositoryImpl(movieService: resolver.resolve(MovieService.self)!)
    }

    // MARK: Home
    // To do: Next we need use child container
    container.register(HomeUseCase.self) { resolver in
      return HomeInteractor(repository: resolver.resolve(MovieRepository.self)!)
    }

    container.register(HomePresenter.self) { resolver in
      return HomePresenter(usecase: resolver.resolve(HomeUseCase.self)!)
    }

    container.register(HomePageView.self) { resolver in
      let presenter = resolver.resolve(HomePresenter.self)!
      return HomePageView(presenter: presenter)
    }

    // MARK: Detail
    // To do: Next we need use child container
    container.register(DetailUseCase.self) { resolver in
      return DetailInteractor(repository: resolver.resolve(MovieRepository.self)!)
    }

    container.register(DetailPresenter.self) { resolver, model in
      let usecase = resolver.resolve(DetailUseCase.self)!
      return DetailPresenter(usecase: usecase, model: model)
    }

    container.register(DetailPageView.self) { (resolver, model: MovieModel) in
      let presenter = resolver.resolve(DetailPresenter.self, argument: model)!
      return DetailPageView(presenter: presenter)
    }

    // MARK: Search
    container.register(SearchUseCase.self) { resolver in
      return SearchInteractor(repository: resolver.resolve(MovieRepository.self)!)
    }

    container.register(SearchPresenter.self) { resolver in
      return SearchPresenter(usecase: resolver.resolve(SearchUseCase.self)!)
    }

    container.register(SearchPageView.self) { resolver in
      return SearchPageView(presenter: resolver.resolve(SearchPresenter.self)!)
    }

    return container
  }
}
