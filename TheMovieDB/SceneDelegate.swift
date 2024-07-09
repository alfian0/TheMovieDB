//
//  SceneDelegate.swift
//  TheMovieDB
//
//  Created by alfian on 08/07/24.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var coordinator: HomeCoordinator?
  var window: UIWindow?

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    let tabBarController = MainCoordinator()
    tabBarController.start()
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = tabBarController.tabBarController
    self.window = window
    window.makeKeyAndVisible()
  }
}
