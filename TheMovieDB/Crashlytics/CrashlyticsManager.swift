//
//  CrashlyticsManager.swift
//  TheMovieDB
//
//  Created by alfian on 01/08/24.
//

import TheMovieDBCore
import FirebaseCrashlytics

class CrashlyticsManager: CrashManager {
  func log(message: String) {
    Crashlytics.crashlytics().log(message)
  }

  func setUserId(_ userId: String) {
    Crashlytics.crashlytics().setUserID(userId)
  }

  func setCustomValue(_ value: Any, forKey key: String) {
    Crashlytics.crashlytics().setCustomValue(value, forKey: key)
  }
}
