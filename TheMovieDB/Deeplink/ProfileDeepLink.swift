//
//  ProfileDeepLink.swift
//  TheMovieDB
//
//  Created by alfian on 31/07/24.
//

import Foundation
import TheMovieDBCore

struct ProfileDeepLink: DeepLink {
  var url: URL

  func handle() {
    // Handle profile deep link
    print("Handling profile deep link for URL: \(url)")
  }
}
