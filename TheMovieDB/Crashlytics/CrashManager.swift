//
//  CrashManager.swift
//  TheMovieDB
//
//  Created by alfian on 01/08/24.
//

import Foundation
import FirebaseCrashlytics

final class CrashManager {
  static let shared = CrashManager()

  private init() {}

  func setUserId(_ userId: String) {
    Crashlytics.crashlytics().setUserID(userId)
  }

  func setValue(_ value: String, key: String) {
    Crashlytics.crashlytics().setCustomValue(value, forKey: key)
  }

  func addLog(_ message: String) {
    Crashlytics.crashlytics().log(message)
  }

  func sendNonFatal(_ error: Error) {
    Crashlytics.crashlytics().record(error: error)
  }
}
