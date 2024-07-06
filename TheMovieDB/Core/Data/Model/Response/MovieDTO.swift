//
//  MovieResponse.swift
//  TheMovieDB
//
//  Created by alfian on 04/07/24.
//

import Foundation

// MARK:
// For better naming convetion all API resmponse model will be use *DTO (Data Transfer Object)
struct ListDTO<D: Codable>: Codable {
  let results: [D]
}

struct MovieDTO: Codable {
  let id: Int?
  let title: String?
  let backdropPath: String?
  let posterPath: String?
  let overview: String?
  let voteAverage: Double?
  let voteCount: Int?
  let runtime: Int?
  let releaseDate: String?
  let casts: CastsDTO?
  let videos: ListDTO<VideosDTO>?
}

struct CastsDTO: Codable {
  let cast: [CastDTO]
}

struct CastDTO: Codable {
  let id: Int?
  let name: String?
  let profilePath: String?
}

struct VideosDTO: Codable {
  let id: String?
  let site: String?
  let key: String?
  let type: String?
}
