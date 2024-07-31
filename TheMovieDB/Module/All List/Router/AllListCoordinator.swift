//
//  AllListRouter.swift
//  TheMovieDB
//
//  Created by alfian on 23/07/24.
//

import SwiftUI
import TheMovieDBCore

final class AllListCoordinator: Coordinator {
  var childCoordinator: [Coordinator] = [Coordinator]()
  var navigationController: UINavigationController
  var models: [MovieModel]

  init(navigationController: UINavigationController, models: [MovieModel]) {
    self.navigationController = navigationController
    self.models = models
  }

  func start() {
    let view = Injection.shared.container.resolve(AllListView.self, arguments: models, self)
    let viewController = UIHostingController(rootView: view)
    viewController.hidesBottomBarWhenPushed = true

    self.navigationController.pushViewController(viewController, animated: true)
  }

  func goToDetail(with model: MovieModel) {
    let view = Injection.shared.container.resolve(DetailPageView.self, argument: model)
    let viewController = UIHostingController(rootView: view)

    self.navigationController.pushViewController(viewController, animated: true)
  }
}
