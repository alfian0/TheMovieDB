//
//  RouterCoordinator.swift
//  TheMovieDB
//
//  Created by alfian on 09/07/24.
//

import UIKit
import SwiftUI

final class ProfileCoordinator: Coordinator {
  var childCoordinator: [Coordinator] = [Coordinator]()
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let view = ProfilePageView()
    let viewController = UIHostingController(rootView: view)

    self.navigationController.pushViewController(viewController, animated: false)
  }
}
