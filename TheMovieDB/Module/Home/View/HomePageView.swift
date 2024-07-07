//
//  ContentView.swift
//  TheMovieDB
//
//  Created by alfian on 04/07/24.
//

import SwiftUI
import Combine

struct HomePageView: View {
  @ObservedObject var presenter: HomePresenter

  var body: some View {
    NavigationStack {
      ScrollView(showsIndicators: false) {
        VStack {
          MoviePosterCalouselView(title: MovieListEndpoint.nowPlaying.description, movies: presenter.nowPlayingMovies)
            .onAppear {
              presenter.getNowPlayingMovies()
            }

          MovieBackdropCarouselView(title: MovieListEndpoint.upcoming.description, movies: presenter.upcomingMovies)
            .onAppear {
              presenter.getUpcomingMovies()
            }

          MovieBackdropCarouselView(title: MovieListEndpoint.topRated.description, movies: presenter.topRatedMovies)
            .onAppear {
              presenter.getToRatedMovies()
            }
        }
      }
      .navigationTitle("The Movie DB")
      .navigationDestination(for: MovieModel.self, destination: { movie in
        presenter.go(to: .detail(movie))
      })
      .toolbar {
        if presenter.isLoading {
          ProgressView()
            .tint(.black)
        }
      }
    }
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
      HomePageView(presenter: Injection.shared.container.resolve(HomePresenter.self)!)
    }
}
