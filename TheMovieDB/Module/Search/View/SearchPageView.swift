//
//  SearchPageView.swift
//  TheMovieDB
//
//  Created by alfian on 06/07/24.
//

import SwiftUI
import TheMovieDBCore

struct SearchPageView: View {
  @ObservedObject var presenter: SearchPresenter

  var body: some View {
//    ScrollView(showsIndicators: false) {
      VStack {
        SearchBar(text: $presenter.searchText)

        List {
          ForEach(presenter.movies) { movie in
            Text(movie.title)
            .onTapGesture {
              presenter.goToDetail(with: movie)
            }
          }
        }
        .listStyle(.plain)
      }
      .navigationBarTitle("Search Movie")
//    }
  }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
      Injection.shared.container.resolve(SearchPageView.self)
    }
}
