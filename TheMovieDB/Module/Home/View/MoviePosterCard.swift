//
//  MoviePosterCard.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MoviePosterCard: View {
  let movie: MovieModel

  var body: some View {
    ZStack {
      Rectangle()
        .fill(Color.gray.opacity(0.1))
        .cornerRadius(8)

      WebImage(url: movie.posterURL)
        .resizable()
        .indicator(.activity)
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
