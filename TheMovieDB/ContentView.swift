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
          Label(router.name, systemImage: router.sytemImage)
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
