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
    Group {
      if presenter.movies.count <= 0 {
        VStack(spacing: 16) {
          Image(systemName: "heart")
            .foregroundColor(.red)

          Text("You can add favorite by tap heart icon on the movie list")
            .font(.body)
            .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 64)
      } else {
        List {
          ForEach(presenter.movies, id: \.self) { movie in
            VStack(alignment: .leading) {
              Text(movie.title)
                .font(.headline)
                .foregroundColor(.red)
              Text(movie.overview)
                .lineLimit(3)
            }
          }
          .onDelete { indexSet in
            for index in indexSet {
              presenter.deleteFavoriteMovie(index: index)
            }
          }
        }
      }
    }
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
