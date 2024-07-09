//
//  SearchBar.swift
//  TheMovieDB
//
//  Created by alfian on 09/07/24.
//

import UIKit
import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
      @Binding var text: String

      init(text: Binding<String>) {
          _text = text
      }

      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          text = searchText
      }
    }

    func makeCoordinator() -> Coordinator {
      return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
      let searchBar = UISearchBar()
      searchBar.delegate = context.coordinator
      searchBar.placeholder = "Input at least 4 character"
      return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
      uiView.text = text
    }
}
