//
//  FavoritePageView.swift
//  TheMovieDB
//
//  Created by alfian on 10/07/24.
//

import SwiftUI

struct FavoritePageView: View {
  @ObservedObject var presenter: FavoritePresenter

  var body: some View {
    List {
      ForEach(presenter.movies) { movie in
        Text(movie.title)
          .font(.headline)
          .foregroundColor(.red)
        Text(movie.overview)
          .lineLimit(3)
      }
    }
    .listStyle(.plain)
    .navigationBarTitle("Favorite")
    .onAppear {
      self.presenter.getFavoriteMovies()
    }
  }
}

struct FavoritePageView_Previews: PreviewProvider {
    static var previews: some View {
      Injection.shared.container.resolve(FavoritePageView.self)
    }
}
