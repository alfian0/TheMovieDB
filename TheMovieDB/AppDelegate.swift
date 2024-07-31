//
//  AppDelegate.swift
//  TheMovieDB
//
//  Created by alfian on 08/07/24.
//

import UIKit
import TheMovieDBCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var deepLinkManager: DeepLinkManager?
  var analyticsManager: AnalyticsManager?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Override point for customization after application launch.
    let productDeepLink = ProductDeepLink(url: URL(string: "myapp://product")!)
    let profileDeepLink = ProfileDeepLink(url: URL(string: "myapp://profile")!)

    deepLinkManager = DefaultDeepLinkManager(deepLinks: [productDeepLink, profileDeepLink])

    let firebaseService = FirebaseAnalyticsService()
    let mixpanelService = MixpanelAnalyticsService()

    analyticsManager = DefaultAnalyticsManager(services: [firebaseService, mixpanelService])

    analyticsManager?.logEvent("app_launch", parameters: nil)

    return true
  }

  // MARK: UISceneSession Lifecycle
  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running,
    // this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    deepLinkManager?.handleDeepLink(url: url)
    return true
  }

  func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
    if userActivity?.activityType == NSUserActivityTypeBrowsingWeb, let url = userActivity?.webpageURL {
      deepLinkManager?.handleDeepLink(url: url)
    }
    return true
  }
}
