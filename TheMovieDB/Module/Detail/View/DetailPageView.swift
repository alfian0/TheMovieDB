//
//  DetailPageView.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import SwiftUI

struct DetailPageView: View {
  @Environment(\.imageCache) var cache: ImageCache
  // MARK: Because we use PropertyWrapper in some class we need use @StateObject than ObservedObject
  @StateObject var presenter: DetailPresenter

  var body: some View {
    ZStack {
      AsyncImage(url: presenter.model.posterURL,
                 cache: cache,
                 placeholder: { Text("Loading...") },
                 image: { Image(uiImage: $0).resizable() })
      .aspectRatio(contentMode: .fit)
      .frame(maxHeight: .infinity, alignment: .top)

      VStack {
        LinearGradient(colors: [
                                .white.opacity(0),
                                .white.opacity(0.5),
                                .white,
                                .white
        ],
                       startPoint: .top,
                       endPoint: .bottom)
      }
      .frame(maxHeight: .infinity, alignment: .bottom)

      ScrollView(showsIndicators: false) {
        VStack {
          HStack {

          }
          .frame(height: 64)

          VStack {
            Text(presenter.model.title)
              .font(.title)
              .fontWeight(.bold)
              .padding(.top, 200)
              .multilineTextAlignment(.center)

            HStack {
              Text(presenter.model.rating)
                .foregroundColor(.blue)
              Text("·")
              Text(presenter.model.score)
                .font(.headline)
              Text("·")
              Text(presenter.model.duration)
                .font(.headline)
            }

            Text(presenter.model.overview)
              .font(.body)
              .multilineTextAlignment(.center)
          }
          .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))

          if !presenter.model.casts.isEmpty {
            CastCarouselView(casts: presenter.model.casts)
          }

          if !presenter.model.videos.isEmpty {
            TrailerCarouselView(videos: presenter.model.videos)
          }
        }
        .padding(.bottom, 16)
      }
    }
    .navigationTitle(presenter.model.title)
    .navigationBarTitleDisplayMode(.inline)
    .ignoresSafeArea()
    .toolbar(.hidden, for: .tabBar)
    .toolbar {
      if presenter.isLoading {
        ProgressView()
          .tint(.black)
      }
    }
    .onAppear {
      presenter.getMovieDetail()
    }
  }
}

struct DetailPageView_Previews: PreviewProvider {
  static var previews: some View {
    let model = MovieModelMapper.mapMovieResponseToEntity(input: StubDataLoader.loadStubMovie()!)
    let presenter = Injection.shared.container.resolve(DetailPresenter.self, argument: model)!
    NavigationView {
      DetailPageView(presenter: presenter)
    }
  }
}
