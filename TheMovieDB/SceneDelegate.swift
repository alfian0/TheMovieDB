//
//  SceneDelegate.swift
//  TheMovieDB
//
//  Created by alfian on 08/07/24.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
      print("scene willConnectTo")
      guard let windowScene = scene as? UIWindowScene else { return }
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: ContentView())
      self.window = window
      window.makeKeyAndVisible()
  }
}
