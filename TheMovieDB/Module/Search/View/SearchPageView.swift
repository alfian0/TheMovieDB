//
//  SearchPageView.swift
//  TheMovieDB
//
//  Created by alfian on 06/07/24.
//

import SwiftUI

struct SearchPageView: View {
  @StateObject var presenter: SearchPresenter

  var body: some View {
    NavigationStack {
      List {
        ForEach(presenter.movies) { movie in
          NavigationLink(value: movie) {
            Text(movie.title)
          }
        }
      }
      .listStyle(.plain)
      .navigationTitle("Search Movie")
      .navigationDestination(for: MovieModel.self, destination: { movie in
        presenter.go(to: .detail(movie))
      })
    }
    .searchable(text: $presenter.searchText, prompt: "Search Movie")
  }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
      Injection.shared.container.resolve(SearchPageView.self)
    }
}
