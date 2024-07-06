//
//  ProfilePageView.swift
//  TheMovieDB
//
//  Created by alfian on 06/07/24.
//

import SwiftUI

struct ProfilePageView: View {
    var body: some View {
      VStack {
        Image(uiImage: UIImage(named: "profile")!)
          .resizable()
          .clipShape(Circle())
          .frame(width: 200, height: 200)
  
        Text("Muhammad Alfiansyah")
          .font(.title)
          .fontWeight(.bold)

        Text("iOS Engineer")
          .font(.title2)
      }
    }
}

struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}
