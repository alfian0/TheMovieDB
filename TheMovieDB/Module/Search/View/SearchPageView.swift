//
//  SearchPageView.swift
//  TheMovieDB
//
//  Created by alfian on 06/07/24.
//

import SwiftUI

struct SearchPageView: View {
  @ObservedObject var presenter: SearchPresenter

  var body: some View {
    NavigationView {
      VStack {
        SearchBar(text: $presenter.searchText)
        
        List {
          ForEach(presenter.movies) { movie in
            NavigationLink(destination: Injection.shared.container.resolve(DetailPageView.self, argument: movie)) {
              Text(movie.title)
            }
          }
        }
        .listStyle(.plain)
      }
      .navigationBarTitle("Search Movie")
    }
  }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
      Injection.shared.container.resolve(SearchPageView.self)
    }
}
