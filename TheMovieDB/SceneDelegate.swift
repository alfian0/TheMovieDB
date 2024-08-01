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
  var coordinator: Coordinator?
  var deepLinkManager: DeepLinkManager?
  var analyticsManager: AnalyticsManager?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = scene as? UIWindowScene else { return }

    // Initialize the main coordinator
    initializeCoordinator(with: windowScene)

    // Initialize the deep link manager
    initializeDeepLinkManager()

    // Initialize the analytics manager
    initializeAnalyticsManager()

    // Log app launch event
    analyticsManager?.logEvent("app_launch", parameters: nil)
    analyticsManager?.setUserId(UUID().uuidString)

    // Handle any deep links from the launch options
    handleDeepLink(from: connectionOptions.userActivities)

//    deepLinkManager?.handleDeepLink(url: URL(string: "myapp://profile?name=Alfian")!)
  }

  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let url = URLContexts.first?.url {
        deepLinkManager?.handleDeepLink(url: url)
    }
  }

  private func initializeCoordinator(with windowScene: UIWindowScene) {
    let navigationController = UINavigationController()
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = navigationController
    self.window = window
    window.makeKeyAndVisible()

    self.coordinator = MainCoordinator(navigationController: navigationController)
    self.coordinator?.start()
  }

  private func initializeDeepLinkManager() {
    guard let coordinator = self.coordinator else { return }
    let productDeepLink = ProductDeepLink(path: "product", coordinator: coordinator)
    let profileDeepLink = ProfileDeepLink(path: "profile", coordinator: coordinator)

    deepLinkManager = DefaultDeepLinkManager(deepLinks: [productDeepLink, profileDeepLink])
  }

  private func initializeAnalyticsManager() {
    let firebaseService = FirebaseAnalyticsService()
    let mixpanelService = MixpanelAnalyticsService()

    analyticsManager = DefaultAnalyticsManager(services: [firebaseService, mixpanelService])
  }

  private func handleDeepLink(from userActivities: Set<NSUserActivity>) {
    if let url = userActivities.first?.webpageURL {
      deepLinkManager?.handleDeepLink(url: url)
    }
  }
}
