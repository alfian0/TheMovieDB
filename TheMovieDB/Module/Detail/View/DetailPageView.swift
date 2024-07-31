//
//  DetailPageView.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import SwiftUI
import SDWebImageSwiftUI
import Podcast_App_Design_System
import TheMovieDBService

struct DetailPageView: View {
  @ObservedObject var presenter: DetailPresenter

  var body: some View {
    ZStack {
      WebImage(url: presenter.model.posterURL)
        .resizable()
        .indicator(.activity)
        .aspectRatio(contentMode: .fit)
        .frame(maxHeight: .infinity, alignment: .top)

      VStack {
        LinearGradient(colors: [
                                .backgroundDefault.opacity(0),
                                .backgroundDefault.opacity(0.5),
                                .backgroundDefault,
                                .backgroundDefault
        ],
                       startPoint: .top,
                       endPoint: .bottom)
      }
      .frame(maxHeight: .infinity, alignment: .bottom)
      .edgesIgnoringSafeArea(.all)

      ScrollView(showsIndicators: false) {
        VStack {
          HStack {

          }
          .frame(height: 64)

          VStack {
            Text(presenter.model.title)
              .font(.Display.m)
              .padding(.top, 200)
              .foregroundColor(.foregroundDefault)
              .multilineTextAlignment(.center)

            HStack {
              Text(presenter.model.rating)
                .foregroundColor(.blue)
              Text("·")
              Text(presenter.model.score)
                .font(.Label.l)
                .foregroundColor(.foregroundDefault)
              Text("·")
              Text(presenter.model.duration)
                .font(.Label.l)
                .foregroundColor(.foregroundDefault)
            }

            Text(presenter.model.overview)
              .font(.Paragraph.l)
              .multilineTextAlignment(.center)
              .foregroundColor(.foregroundDefault)
          }
          .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))

          if !presenter.model.casts.isEmpty {
            SectionView(
              axis: .horizontal,
              title: "Cast",
              models: presenter.model.casts,
              content: { cast in
                VStack {
                  WebImage(url: cast.profileURL)
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())

                  Text(cast.name)
                    .font(.Label.l)
                    .foregroundColor(.foregroundDefault)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                }
                .frame(width: 64)
              }, actionTitle: "", action: {

              })
          }

          if !presenter.model.videos.isEmpty {
            SectionView(
              axis: .horizontal,
              title: "Trailer",
              models: presenter.model.videos,
              content: { video in
                ZStack {
                  Rectangle()
                    .fill(Color.gray.opacity(0.1))

                  WebImage(url: video.thumbnailURL)
                    .resizable()
                    .indicator(.activity)
                    .cornerRadius(8)
                }
                .padding(.top, 8)
                .padding(.bottom, 8)
                .frame(width: 16/9*120)
                .aspectRatio(16/9, contentMode: .fill)
                .frame(height: 120+16)
              }, actionTitle: "", action: {

              })
          }
        }
        .padding(.bottom, 16)
      }
    }
    .navigationBarTitle(Text(presenter.model.title), displayMode: .inline)
    .edgesIgnoringSafeArea([.top])
    .navigationBarItems(trailing: ActivityIndicator(isAnimating: $presenter.isLoading))
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
        .preferredColorScheme(.dark)
    }
  }
}
