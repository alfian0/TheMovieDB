//
//  MovieBackdropCarouselView.swift
//  TheMovieDB
//
//  Created by alfian on 04/07/24.
//

import SwiftUI

struct MovieBackdropCarouselView: View {
  let title: String
  let movies: [MovieModel]

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(self.title)
        .font(.title)
        .fontWeight(.bold)
        .padding(.horizontal)

      ScrollView(.horizontal, showsIndicators: false) {
        HStack(alignment: .top, spacing: 16) {
          ForEach(self.movies) { movie in
            NavigationLink(value: movie) {
              MovieBackdropCard(movie: movie)
                .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                .padding(.top, 8)
                .padding(.bottom, 8)
            }
          }
        }
      }
      .frame(height: 200 + 16)
    }
  }
}

struct MovieBackdropCarouselView_Previews: PreviewProvider {
    static var previews: some View {
      MovieBackdropCarouselView(title: "Now Playing",
                                movies: MovieModelMapper
        .mapMovieResponsesToEntities(input: StubDataLoader.loadStubMovies()))
    }
}
