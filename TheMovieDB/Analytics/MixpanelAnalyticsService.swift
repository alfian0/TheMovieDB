//
//  MixpanelAnalyticsService.swift
//  TheMovieDB
//
//  Created by alfian on 31/07/24.
//

import Foundation
import TheMovieDBCore

class MixpanelAnalyticsService: AnalyticsService {
  func logEvent(_ name: String, parameters: [String: Any]?) {
    // Log event to Mixpanel
    print("Logging event to Mixpanel: \(name), parameters: \(String(describing: parameters))")
  }

  func setUserId(_ userId: String) {
    // Set user ID in Mixpanel
    print("Setting user ID in Mixpanel: \(userId)")
  }

  func setUserProperty(_ name: String, value: String) {
    // Set user property in Mixpanel
    print("Setting user property in Mixpanel: \(name) = \(value)")
  }
}
