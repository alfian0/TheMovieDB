//
//  AllListView.swift
//  TheMovieDB
//
//  Created by alfian on 23/07/24.
//

import SwiftUI
import Podcast_App_Design_System

struct AllListView: View {
  @ObservedObject var presenter: AllListPresenter

  var body: some View {
    GridStack(
      axis: .vertical,
      dividedBy: 2,
      models: presenter.movies) { movie in
        MoviePosterCard(movie: movie)
          .onTapGesture {
            presenter.goToDetail(with: movie)
          }
      }
      .padding(.horizontal, 8)
  }
}

struct AllListView_Previews: PreviewProvider {
    static var previews: some View {
      AllListView(
        presenter: AllListPresenter(movies: [],
                                    coordinator: AllListCoordinator(navigationController: UINavigationController(),
                                                                    models: [])
                                   )
      )
    }
}
