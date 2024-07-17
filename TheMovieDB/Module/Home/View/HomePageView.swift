//
//  ContentView.swift
//  TheMovieDB
//
//  Created by alfian on 04/07/24.
//

import SwiftUI
import Combine
import TheMovieDBCore

struct HomePageView: View {
  @ObservedObject var presenter: HomePresenter

  var body: some View {
//    NavigationView {
      ScrollView(showsIndicators: false) {
        VStack {
          MoviePosterCalouselView(
            title: MovieListEndpoint.nowPlaying.description,
            movies: presenter.nowPlayingMovies) { movie in
              presenter.goToDetail(with: movie)
            }
            .onAppear {
              presenter.getNowPlayingMovies()
            }

          MovieBackdropCarouselView(
            title: MovieListEndpoint.upcoming.description,
            movies: presenter.upcomingMovies, didTap: { movie in
              presenter.goToDetail(with: movie)
            }, didTapFavorite: { movie in
              presenter.addFavorite(with: movie)
            })
            .onAppear {
              presenter.getUpcomingMovies()
            }

          MovieBackdropCarouselView(
            title: MovieListEndpoint.topRated.description,
            movies: presenter.topRatedMovies, didTap: { movie in
              presenter.goToDetail(with: movie)
            }, didTapFavorite: { movie in
              presenter.addFavorite(with: movie)
            })
            .onAppear {
              presenter.getToRatedMovies()
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
//    }
  }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
      HomePageView(presenter: Injection.shared.container.resolve(HomePresenter.self)!)
    }
}
