//
//  ProductDeepLink.swift
//  TheMovieDB
//
//  Created by alfian on 31/07/24.
//

import Foundation
import TheMovieDBCore

struct ProductDeepLink: DeepLink {
  var url: URL

  func handle() {
    // Handle product deep link
    print("Handling product deep link for URL: \(url)")
  }
}
