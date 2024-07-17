//
//  FavoritePageView.swift
//  TheMovieDB
//
//  Created by alfian on 10/07/24.
//

import SwiftUI
import Podcast_App_Design_System

struct FavoritePageView: View {
  @ObservedObject var presenter: FavoritePresenter

  var body: some View {
    GridStack(axis: .vertical, models: presenter.movies) { movie in
      VStack(alignment: .leading) {
        Text(movie.title)
          .font(.headline)
          .foregroundColor(.red)
        Text(movie.overview)
          .lineLimit(3)
      }
    }
    .padding(.horizontal, 8)
    .navigationBarTitle("Favorite")
    .onAppear {
      self.presenter.getFavoriteMovies()
    }
  }
}

struct FavoritePageView_Previews: PreviewProvider {
    static var previews: some View {
      let coordinator = FavoriteCoordinator(navigationController: UINavigationController())
      if let presenter = Injection.shared.container.resolve(FavoritePresenter.self, argument: coordinator) {
        FavoritePageView(presenter: presenter)
          .preferredColorScheme(.dark)
      }
    }
}
