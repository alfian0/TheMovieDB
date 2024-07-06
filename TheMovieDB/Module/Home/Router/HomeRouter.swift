//
//  HomeRouter.swift
//  TheMovieDB
//
//  Created by alfian on 06/07/24.
//

import SwiftUI

enum HomeRouter {
  case detail(MovieModel)

  @ViewBuilder
  var view: some View {
    switch self {
    case .detail(let model):
      Injection.shared.container.resolve(DetailPageView.self, argument: model)!
    }
  }
}
