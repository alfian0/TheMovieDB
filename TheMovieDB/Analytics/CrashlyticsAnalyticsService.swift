//
//  CrashlyticsAnalyticsService.swift
//  TheMovieDB
//
//  Created by alfian on 02/08/24.
//

import Foundation
import TheMovieDBCore
import FirebaseCrashlytics

class CrashlyticsAnalyticsService: AnalyticsService {
  func logEvent(_ name: String, parameters: [String: Any]?) {
    Crashlytics.crashlytics().log("Event: \(name), Parameters: \(parameters ?? [:])")
  }

  func setUserId(_ userId: String) {
    Crashlytics.crashlytics().setUserID(userId)
  }

  func setUserProperty(_ name: String, value: String) {
    Crashlytics.crashlytics().setCustomValue(value, forKey: name)
  }
}
