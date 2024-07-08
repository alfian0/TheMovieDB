//
//  MovieModel.swift
//  TheMovieDB
//
//  Created by alfian on 04/07/24.
//

import Foundation

struct MovieModel: Identifiable, Hashable {
  let id: Int
  let title: String
  var backdropURL: URL
  let posterURL: URL
  let overview: String
  let rating: String
  let score: String
  let duration: String
  let releaseDate: String
  let casts: [CastModel]
  let videos: [VideoModel]

  static func == (lhs: MovieModel, rhs: MovieModel) -> Bool {
    return lhs.id == rhs.id
  }
}

struct CastModel: Identifiable, Hashable {
  let id: Int
  let name: String
  let profileURL: URL

  static func == (lhs: CastModel, rhs: CastModel) -> Bool {
    return lhs.id == rhs.id
  }
}

struct VideoModel: Hashable {
  let site: String
  let key: String
  let thumbnailURL: URL

  static func == (lhs: VideoModel, rhs: VideoModel) -> Bool {
    return lhs.id == rhs.id
  }
}

extension VideoModel: Identifiable {
  var id: String {
    return key
  }
}
