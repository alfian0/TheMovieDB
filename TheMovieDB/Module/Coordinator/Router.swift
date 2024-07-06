//
//  Coordinator.swift
//  TheMovieDB
//
//  Created by alfian on 06/07/24.
//

import SwiftUI

enum Router: Identifiable {
  case home
  case favorite
  case search
  case about

  var name: String {
    switch self {
    case .home:
      return "Home"
    case .favorite:
      return "Favorite"
    case .search:
      return "Search"
    case .about:
      return "About"
    }
  }

  var sytemImage: String {
    switch self {
    case .home:
      return "house.circle.fill"
    case .favorite:
      return "heart.circle.fill"
    case .search:
      return "magnifyingglass.circle.fill"
    case .about:
      return "person.circle.fill"
    }
  }

  @ViewBuilder
  var view: some View {
    switch self {
    case .home:
      Injection.shared.container.resolve(HomePageView.self)
    case .favorite:
      Text("Favorite")
    case .search:
      Text("Search")
    case .about:
      ProfilePageView()
    }
  }

  var id: String {
    return name
  }
}
