//
//  MoviePosterCalouselView.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import SwiftUI

struct MoviePosterCalouselView: View {
  let title: String
  let movies: [MovieModel]
  var didTap: ((MovieModel) -> Void)?

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(self.title)
        .font(.title)
        .fontWeight(.bold)
        .padding(.horizontal)

      ScrollView(.horizontal, showsIndicators: false) {
        HStack(alignment: .top, spacing: 16) {
          ForEach(self.movies) { movie in
//            NavigationLink(destination: Injection.shared.container.resolve(DetailPageView.self, argument: movie)) {
              MoviePosterCard(movie: movie)
                .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                .padding(.top, 8)
                .padding(.bottom, 8)
                .onTapGesture {
                  self.didTap?(movie)
                }
//            }
          }
        }
      }
      .frame(height: 304 + 16)
    }
  }
}

struct MoviePosterCalouselView_Previews: PreviewProvider {
    static var previews: some View {
      MoviePosterCalouselView(title: "Now Playing",
                              movies: MovieModelMapper
        .mapMovieResponsesToEntities(input: StubDataLoader.loadStubMovies()))
    }
}
