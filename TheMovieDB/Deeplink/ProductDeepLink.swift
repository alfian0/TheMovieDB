//
//  ProductDeepLink.swift
//  TheMovieDB
//
//  Created by alfian on 31/07/24.
//

import UIKit
import TheMovieDBCore

struct ProductDeepLink: DeepLink {
  var path: String
  var coordinator: Coordinator

  func handle(url: URL) {
    guard let selectedCoordinator = coordinator.childCoordinator.filter({ $0 is HomeCoordinator }).first,
          let mainCoordinator = coordinator as? MainCoordinator else {
      return
    }
    mainCoordinator.tabBarController.selectedIndex = 0
    var viewControllers = selectedCoordinator.navigationController.viewControllers
    let viewController = UIViewController()
    viewController.view.backgroundColor = .white
    viewControllers.append(viewController)
    selectedCoordinator.navigationController.setViewControllers(viewControllers, animated: false)
  }
}
