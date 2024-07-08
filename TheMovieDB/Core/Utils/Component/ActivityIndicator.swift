//
//  ActivityIndicator.swift
//  TheMovieDB
//
//  Created by alfian on 08/07/24.
//

import SwiftUI
import UIKit

struct ActivityIndicator: UIViewRepresentable {
  @Binding var isAnimating: Bool

  func makeUIView(context: Context) -> UIActivityIndicatorView {
    let indicator = UIActivityIndicatorView(style: .medium)
    indicator.hidesWhenStopped = true
    return indicator
  }

  func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
    isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
  }
}

struct ProgressView: UIViewRepresentable {

  func makeUIView(context: Context) -> UIActivityIndicatorView {
    let indicator = UIActivityIndicatorView(style: .medium)
    indicator.hidesWhenStopped = true
    indicator.startAnimating()
    return indicator
  }

  func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
    
  }
}
