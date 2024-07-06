//
//  MoviePosterCard.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import SwiftUI

struct MoviePosterCard: View {
  let movie: MovieModel
  @Environment(\.imageCache) var cache: ImageCache

  var body: some View {
    ZStack {
      Rectangle()
        .fill(Color.gray.opacity(0.1))
        .cornerRadius(8)

      AsyncImage(url: movie.posterURL,
                 cache: cache,
                 placeholder: { ProgressView() },
                 image: { Image(uiImage: $0) })
        .cornerRadius(8)
        .aspectRatio(contentMode: .fit)
        .shadow(radius: 4)
    }
    .frame(width: 206, height: 304)
  }
}

struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
      MoviePosterCard(movie: MovieModelMapper.mapMovieResponseToEntity(input: StubDataLoader.loadStubMovie()!))
    }
}
