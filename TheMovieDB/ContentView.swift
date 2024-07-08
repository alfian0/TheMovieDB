//
//  ContentView.swift
//  TheMovieDB
//
//  Created by alfian on 06/07/24.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      ForEach([Router.home, Router.favorite, Router.search, Router.about]) { router in
        router.view.tabItem {
          Image(systemName: router.sytemImage)
          Text(router.name)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
