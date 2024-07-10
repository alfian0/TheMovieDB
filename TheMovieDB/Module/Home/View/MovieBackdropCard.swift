//
//  MovieBackdropCard.swift
//  TheMovieDB
//
//  Created by alfian on 04/07/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieBackdropCard: View {
  let movie: MovieModel
  var didTapFavorite: (() -> Void)?

  var body: some View {
    VStack(alignment: .leading) {
      ZStack {
        Rectangle()
          .fill(Color.gray.opacity(0.1))
          .cornerRadius(8)

        WebImage(url: movie.backdropURL)
          .resizable()
          .indicator(.activity)
      }
      .aspectRatio(16/9, contentMode: .fit)
      .cornerRadius(8)
      .shadow(radius: 4)

      HStack {
        VStack(alignment: .leading) {
          Text(movie.title)
            .foregroundColor(.black.opacity(0.6))
            .fontWeight(.bold)
          HStack {
            Text(movie.rating)
              .foregroundColor(.blue)
            Text(movie.score)
              .foregroundColor(.black)
          }
        }
        Spacer()
        Image(systemName: movie.isFavorite ? "heart.fill" :  "heart")
          .onTapGesture {
            self.didTapFavorite?()
          }
          .foregroundColor(.red)
      }
    }
    .lineLimit(1)
  }
}

struct MovieBackdropCard_Previews: PreviewProvider {
  static var previews: some View {
    MovieBackdropCard(movie: MovieModelMapper.mapMovieResponseToEntity(input: StubDataLoader.loadStubMovie()!))
  }
}
