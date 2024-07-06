//
//  TrailerCarouselView.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import SwiftUI

struct TrailerCarouselView: View {
  let videos: [VideoModel]
  @Environment(\.imageCache) var cache: ImageCache

  var body: some View {
    VStack {
      Text("Trailer")
        .font(.title2)
        .fontWeight(.bold)

      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(videos) { video in
            ZStack {
              Rectangle()
                .fill(Color.gray.opacity(0.1))

              AsyncImage(url: video.thumbnailURL,
                         cache: cache,
                         placeholder: { ProgressView() },
                         image: { Image(uiImage: $0).resizable() })
              .cornerRadius(8)
              .aspectRatio(16/9, contentMode: .fit)
            }
            .padding(.leading, video.id == self.videos.first!.id ? 16 : 0)
            .padding(.trailing, video.id == self.videos.last!.id ? 16 : 0)
            .padding(.top, 8)
            .padding(.bottom, 8)
          }
        }
      }
      .frame(height: 120)
    }
  }
}

struct TrailerCarouselView_Previews: PreviewProvider {
  static var previews: some View {
      TrailerCarouselView(videos: [
        VideoModel(site: "",
                   key: "1",
                   thumbnailURL: URL(string: "https://blog.photoadking.com/wp-content/uploads/2021/06/1673927931336.jpg")!),
        VideoModel(site: "",
                   key: "2",
                   thumbnailURL: URL(string: "https://i.sstatic.net/ekfR7.gif")!)
      ])
  }
}
