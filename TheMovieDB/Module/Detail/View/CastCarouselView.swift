//
//  CastCarouselView.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import SwiftUI

struct CastCarouselView: View {
  let casts: [CastModel]
  @Environment(\.imageCache) var cache: ImageCache

  var body: some View {
    VStack {
      Text("Cast")
//        .font(.title2)
        .fontWeight(.bold)

      ScrollView(.horizontal, showsIndicators: false) {
        HStack(alignment: .top, spacing: 16) {
          ForEach(casts) { cast in
            VStack {
              AsyncImage(url: cast.profileURL,
                         cache: cache,
                         placeholder: { ProgressView() },
                         image: { Image(uiImage: $0).resizable() })
              .aspectRatio(contentMode: .fill)
              .frame(width: 64, height: 64)
              .clipShape(Circle())

              Text(cast.name)
                .multilineTextAlignment(.center)
            }
            .frame(width: 64)
            .lineLimit(3)
            .padding(.leading, cast.id == self.casts.first!.id ? 16 : 0)
            .padding(.trailing, cast.id == self.casts.last!.id ? 16 : 0)
          }
        }
      }
    }
  }
}

struct CastCarouselView_Previews: PreviewProvider {
    static var previews: some View {
      CastCarouselView(casts: [])
    }
}
