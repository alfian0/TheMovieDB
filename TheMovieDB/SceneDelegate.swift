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

        // Handle any deep links from the launch options
        handleDeepLink(from: connectionOptions.userActivities)
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            deepLinkManager?.handleDeepLink(url: url)
        }
    }

    private func initializeCoordinator(with windowScene: UIWindowScene) {
        let mainCoordinator = MainCoordinator()
        mainCoordinator.start()

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = mainCoordinator.tabBarController
        self.window = window
        window.makeKeyAndVisible()
    }

    private func initializeDeepLinkManager() {
        let productDeepLink = ProductDeepLink(url: URL(string: "myapp://product")!)
        let profileDeepLink = ProfileDeepLink(url: URL(string: "myapp://profile")!)

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
