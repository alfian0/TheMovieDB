//
//  ContentView.swift
//  TheMovieDB
//
//  Created by alfian on 04/07/24.
//

import SwiftUI
import Combine
import TheMovieDBCore
import Podcast_App_Design_System

struct HomePageView: View {
  @ObservedObject var presenter: HomePresenter

  var body: some View {
    ZStack {
      Color.backgroundDefault
        .edgesIgnoringSafeArea(.all)

      ScrollView(showsIndicators: false) {
        VStack {
          SectionView(axis: .horizontal, title: MovieListEndpoint.nowPlaying.description, models: presenter.nowPlayingMovies) { movie in
            MoviePosterCard(movie: movie)
              .onTapGesture {
                presenter.goToDetail(with: movie)
              }
          }
          .onAppear {
            presenter.getNowPlayingMovies()
          }

          SectionView(axis: .horizontal,
                      title: MovieListEndpoint.upcoming.description,
                      models: presenter.upcomingMovies) { movie in
            MovieBackdropCard(movie: movie) {
              presenter.addFavorite(with: movie)
            }
            .onTapGesture {
              presenter.goToDetail(with: movie)
            }
            .frame(height: 200 + 16)
          }
          .onAppear {
            presenter.getUpcomingMovies()
          }

          SectionView(axis: .horizontal,
                      title: MovieListEndpoint.topRated.description,
                      models: presenter.topRatedMovies) { movie in
            MovieBackdropCard(movie: movie) {
              presenter.addFavorite(with: movie)
            }
            .onTapGesture {
              presenter.goToDetail(with: movie)
            }
            .frame(height: 200 + 16)
          }
          .onAppear {
            presenter.getToRatedMovies()
          }
        }
      }
    }
    .navigationBarTitle("The Movie DB")
    .navigationBarItems(trailing: ActivityIndicator(isAnimating: $presenter.isLoading))
    .alert(isPresented: $presenter.isError) {
      Alert(
        title: Text("Error"),
        message: Text(presenter.errorMessage ?? "Unknow")
      )
    }
  }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
      let coordinator = HomeCoordinator(navigationController: UINavigationController())
      if let presenter = Injection.shared.container.resolve(HomePresenter.self, argument: coordinator) {
        HomePageView(presenter: presenter)
          .preferredColorScheme(.dark)
      }
    }
}
