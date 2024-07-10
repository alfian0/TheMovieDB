//
//  Injection.swift
//  TheMovieDB
//
//  Created by alfian on 06/07/24.
//

import Foundation
import Swinject
import CoreData

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
      #if FRAMEWORK
      return AlamofireAuthenticatedClient()
      #else
      return AuthenticatedHTTPClient()
      #endif
    }

    container.register(MovieService.self) { resolver in
      return MovieServiceImpl(client: resolver.resolve(HTTPClient.self)!)
    }

    container.register(FavoriteService.self) { _ in
      return FavoriteServiceImp(with: CoreDataClient(container: NSPersistentContainer(name: "MovieContainer")))
    }

    container.register(MovieRepository.self) { resolver in
//      return JSONRepository()
      return MovieRepositoryImpl(movieService: resolver.resolve(MovieService.self)!,
                                 favoriteService: resolver.resolve(FavoriteService.self)!)
    }

    // MARK: Home
    // To do: Next we need use child container
    container.register(HomeUseCase.self) { resolver in
      return HomeInteractor(repository: resolver.resolve(MovieRepository.self)!)
    }

    container.register(HomePresenter.self) { resolver, coordinator in
      return HomePresenter(usecase: resolver.resolve(HomeUseCase.self)!, coordinator: coordinator)
    }

    container.register(HomePageView.self) { (resolver, coordinator: HomeCoordinator) in
      let presenter = resolver.resolve(HomePresenter.self, argument: coordinator)!
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

    container.register(SearchPresenter.self) { resolver, coordinator in
      return SearchPresenter(usecase: resolver.resolve(SearchUseCase.self)!, coordinator: coordinator)
    }

    container.register(SearchPageView.self) { (resolver, coordinator: SearchCoordinator) in
      let presenter = resolver.resolve(SearchPresenter.self, argument: coordinator)!
      return SearchPageView(presenter: presenter)
    }

    // MARK: Favorite
    container.register(FavoriteUseCase.self) { resolver in
      return FavoriteInteractor(repository: resolver.resolve(MovieRepository.self)!)
    }

    container.register(FavoritePresenter.self) { resolver, coordinator in
      return FavoritePresenter(usecase: resolver.resolve(FavoriteUseCase.self)!, coordinator: coordinator)
    }

    container.register(FavoritePageView.self) { (resolver, coordinator: FavoriteCoordinator) in
      let presenter = resolver.resolve(FavoritePresenter.self, argument: coordinator)!
      return FavoritePageView(presenter: presenter)
    }

    return container
  }
}
