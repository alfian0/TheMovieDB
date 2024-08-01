//
//  ProfileDeepLink.swift
//  TheMovieDB
//
//  Created by alfian on 31/07/24.
//

import UIKit
import TheMovieDBCore

struct ProfileDeepLink: DeepLink {
  var path: String
  var coordinator: Coordinator

  func handle(url: URL) {
    guard let selectedCoordinator = coordinator.childCoordinator.filter({ $0 is ProfileCoordinator }).first,
          let mainCoordinator = coordinator as? MainCoordinator,
          let urlComponent = URLComponents(string: url.absoluteString),
          let queryItems = urlComponent.queryItems,
          let name = queryItems.filter({ $0.name == "name" }).first?.value else {
      return
    }
    mainCoordinator.tabBarController.selectedIndex = 3
    var viewControllers = selectedCoordinator.navigationController.viewControllers
    let viewController = UIViewController()
    viewController.title = name
    viewController.view.backgroundColor = .white
    viewControllers.append(viewController)
    selectedCoordinator.navigationController.setViewControllers(viewControllers, animated: false)
  }
}
