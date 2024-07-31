//
//  FirebaseAnalyticsService.swift
//  TheMovieDB
//
//  Created by alfian on 31/07/24.
//

import Foundation
import TheMovieDBCore

class FirebaseAnalyticsService: AnalyticsService {
  func logEvent(_ name: String, parameters: [String: Any]?) {
    // Log event to Firebase
    print("Logging event to Firebase: \(name), parameters: \(String(describing: parameters))")
  }

  func setUserId(_ userId: String) {
    // Set user ID in Firebase
    print("Setting user ID in Firebase: \(userId)")
  }

  func setUserProperty(_ name: String, value: String) {
    // Set user property in Firebase
    print("Setting user property in Firebase: \(name) = \(value)")
  }
}
