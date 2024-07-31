//
//  FirebaseAnalyticsService.swift
//  TheMovieDB
//
//  Created by alfian on 31/07/24.
//

import Foundation
import TheMovieDBCore
import FirebaseAnalytics

class FirebaseAnalyticsService: AnalyticsService {
  func logEvent(_ name: String, parameters: [String: Any]?) {
    Analytics.logEvent(name, parameters: parameters)
  }

  func setUserId(_ userId: String) {
    Analytics.setUserID(userId)
  }

  func setUserProperty(_ name: String, value: String) {
    Analytics.setUserProperty(value, forName: name)
  }
}
