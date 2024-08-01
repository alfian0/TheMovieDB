//
//  Configuration.swift
//  TheMovieDB
//
//  Created by alfian on 01/08/24.
//

import Foundation
import os.log

enum Configuration {
  enum Error: Swift.Error {
    case missingKey, invalidValue
  }

  static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
    guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
      os_log("Missing key: %@", log: .default, type: .error, key)
      throw Error.missingKey
    }

    if let value = object as? T {
      return value
    } else if let string = object as? String, let value = T(string) {
      return value
    } else {
      os_log("Invalid value for key: %@", log: .default, type: .error, key)
      throw Error.invalidValue
    }
  }
}

enum API {
  static var key: String {
    return (try? Configuration.value(for: "API_KEY")) ?? ""
  }

  static var urlString: String {
    return "https://" + ((try? Configuration.value(for: "API_BASE_URL")) ?? "")
  }

  static var imageUrlPlaceholderString: String {
    return "https://" + ((try? Configuration.value(for: "API_IMAGE_PLACEHOLDER")) ?? "")
  }

  static var url: URL {
    return URL(string: urlString)!
  }

  static var imageUrlPlaceholder: URL {
    return URL(string: imageUrlPlaceholderString)!
  }
}
