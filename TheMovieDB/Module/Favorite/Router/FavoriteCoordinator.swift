//
//  FavoriteCoordinator.swift
//  TheMovieDB
//
//  Created by alfian on 10/07/24.
//

import SwiftUI
import TheMovieDBCore

final class FavoriteCoordinator: Coordinator {
  var childCoordinator: [Coordinator] = [Coordinator]()
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let view = Injection.shared.container.resolve(FavoritePageView.self, argument: self)
    let viewController = UIHostingController(rootView: view)

    self.navigationController.pushViewController(viewController, animated: false)
  }
}
