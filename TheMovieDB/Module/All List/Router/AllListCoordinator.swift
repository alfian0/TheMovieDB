//
//  AllListRouter.swift
//  TheMovieDB
//
//  Created by alfian on 23/07/24.
//

import SwiftUI

final class AllListCoordinator {
  var childCoordinator: [Coordinator] = [Coordinator]()
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start(with models: [MovieModel]) {
    let view = Injection.shared.container.resolve(AllListView.self, arguments: models, self)
    let viewController = UIHostingController(rootView: view)

    self.navigationController.pushViewController(viewController, animated: true)
  }

  func goToDetail(with model: MovieModel) {
    let view = Injection.shared.container.resolve(DetailPageView.self, argument: model)
    let viewController = UIHostingController(rootView: view)
    viewController.hidesBottomBarWhenPushed = true

    self.navigationController.pushViewController(viewController, animated: true)
  }
}
