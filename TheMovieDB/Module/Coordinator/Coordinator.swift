//
//  Coordinator.swift
//  TheMovieDB
//
//  Created by alfian on 09/07/24.
//

import UIKit
import SwiftUI
import TheMovieDBCore
import Podcast_App_Design_System

final class MainCoordinator {
  var childCoordinator: [Coordinator] = [Coordinator]()
  var tabBarController: UITabBarController = {
    let tabBarController = UITabBarController()
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .white

    tabBarController.tabBar.standardAppearance = appearance
    if #available(iOS 15.0, *) {
      tabBarController.tabBar.scrollEdgeAppearance = appearance
    }
    return tabBarController
  }()

  func start() {
    NotoSansFont.registerFonts()
    InterFont.registerFonts()

    let homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
    homeCoordinator.start()
    homeCoordinator.navigationController.tabBarItem = UITabBarItem(
      title: "Home",
      image: UIImage(systemName: "house.circle"),
      selectedImage: UIImage(systemName: "house.circle.fill")
    )
    self.childCoordinator.append(homeCoordinator)

    let favoriteCoordinator = FavoriteCoordinator(navigationController: UINavigationController())
    favoriteCoordinator.start()
    favoriteCoordinator.navigationController.tabBarItem = UITabBarItem(
      title: "Favorite",
      image: UIImage(systemName: "heart.circle"),
      selectedImage: UIImage(systemName: "heart.circle.fill")
    )
    self.childCoordinator.append(favoriteCoordinator)

    let searchCoordinator = SearchCoordinator(navigationController: UINavigationController())
    searchCoordinator.start()
    searchCoordinator.navigationController.tabBarItem = UITabBarItem(
      title: "Search",
      image: UIImage(systemName: "magnifyingglass.circle"),
      selectedImage: UIImage(systemName: "magnifyingglass.circle.fill")
    )
    self.childCoordinator.append(searchCoordinator)

    let profileCoordinator = ProfileCoordinator(navigationController: UINavigationController())
    profileCoordinator.start()
    profileCoordinator.navigationController.tabBarItem = UITabBarItem(
      title: "About",
      image: UIImage(systemName: "person.circle"),
      selectedImage: UIImage(systemName: "person.circle.fill")
    )
    self.childCoordinator.append(profileCoordinator)

    self.tabBarController.viewControllers = [
      homeCoordinator.navigationController,
      favoriteCoordinator.navigationController,
      searchCoordinator.navigationController,
      profileCoordinator.navigationController
    ]
  }
}
