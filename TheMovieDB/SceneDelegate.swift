//
//  SceneDelegate.swift
//  TheMovieDB
//
//  Created by alfian on 08/07/24.
//

import SwiftUI
import TheMovieDBCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  var coordinator: HomeCoordinator?
  var deepLinkManager: DeepLinkManager?
  var analyticsManager: AnalyticsManager?

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

    let productDeepLink = ProductDeepLink(url: URL(string: "myapp://product")!)
    let profileDeepLink = ProfileDeepLink(url: URL(string: "myapp://profile")!)

    deepLinkManager = DefaultDeepLinkManager(deepLinks: [productDeepLink, profileDeepLink])

    let firebaseService = FirebaseAnalyticsService()
    let mixpanelService = MixpanelAnalyticsService()

    analyticsManager = DefaultAnalyticsManager(services: [firebaseService, mixpanelService])

    analyticsManager?.logEvent("app_launch", parameters: nil)

    if let url = connectionOptions.userActivities.first?.webpageURL {
      deepLinkManager?.handleDeepLink(url: url)
    }
  }

  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let url = URLContexts.first?.url {
      deepLinkManager?.handleDeepLink(url: url)
    }
  }
}
