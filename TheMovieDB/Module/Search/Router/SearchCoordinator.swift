//
//  SearchCoordinator.swift
//  TheMovieDB
//
//  Created by alfian on 09/07/24.
//

import UIKit
import SwiftUI

final class SearchCoordinator: Coordinator {
  var childCoordinator: [Coordinator] = [Coordinator]()
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let view = Injection.shared.container.resolve(SearchPageView.self, argument: self)
    let viewController = UIHostingController(rootView: view)

    self.navigationController.pushViewController(viewController, animated: false)
  }

  func goToDetail(with model: MovieModel) {
    let view = Injection.shared.container.resolve(DetailPageView.self, argument: model)
    let viewController = UIHostingController(rootView: view)
    viewController.hidesBottomBarWhenPushed = true

    self.navigationController.pushViewController(viewController, animated: true)
  }
}
