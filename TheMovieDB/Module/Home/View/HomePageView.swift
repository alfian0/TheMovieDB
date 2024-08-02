//
//  ContentView.swift
//  TheMovieDB
//
//  Created by alfian on 04/07/24.
//

import SwiftUI
import Combine
import Podcast_App_Design_System
import TheMovieDBService
import TheMovieDBCore

struct HomePageView: View {
  @ObservedObject var presenter: HomePresenter

  var body: some View {
    ZStack {
      Color.backgroundDefault
        .edgesIgnoringSafeArea(.all)

      ScrollView(showsIndicators: false) {
        VStack {
          SectionView(
            axis: .horizontal,
            title: MovieListEndpoint.nowPlaying.description,
            models: presenter.nowPlayingMovies,
            content: { movie in
              MoviePosterCard(movie: movie)
                .onTapGesture {
                  presenter.goToDetail(with: movie)
                }
            }, actionTitle: "See all", action: {
              presenter.goToAllList(with: presenter.nowPlayingMovies)
            })
            .onAppear {
              presenter.getNowPlayingMovies()
            }

          SectionView(
            axis: .horizontal,
            title: MovieListEndpoint.upcoming.description,
            models: presenter.upcomingMovies,
            content: { movie in
              MovieBackdropCard(movie: movie) {
                presenter.addFavorite(with: movie)
              }
              .onTapGesture {
                presenter.goToDetail(with: movie)
              }
              .frame(height: 200 + 16)
            }, actionTitle: "See all", action: {
              presenter.goToAllList(with: presenter.upcomingMovies)
            })
            .onAppear {
              presenter.getUpcomingMovies()
            }

          SectionView(
            axis: .horizontal,
            title: MovieListEndpoint.topRated.description,
            models: presenter.topRatedMovies,
            content: { movie in
              MovieBackdropCard(movie: movie) {
                presenter.addFavorite(with: movie)
              }
              .onTapGesture {
                presenter.goToDetail(with: movie)
              }
              .frame(height: 200 + 16)
            }, actionTitle: "See all", action: {
              presenter.goToAllList(with: presenter.topRatedMovies)
            })
            .onAppear {
              presenter.getToRatedMovies()
            }
        }
      }
    }
    .onAppear {
      DefaultAnalyticsManager.shared.logEvent(
        .screenView,
        parameters: [
          "screen_name": "HomePageView"
        ]
      )
      DefaultAnalyticsManager.shared.logEvent(.sessionStart, parameters: nil)
//      PerformanceManager.shared.startTrace(name: "performance_screen_time")
    }
    .onDisappear {
      DefaultAnalyticsManager.shared.logEvent(.sessionEnd, parameters: nil)
//      PerformanceManager.shared.stopTrace(name: "performance_screen_time")
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
