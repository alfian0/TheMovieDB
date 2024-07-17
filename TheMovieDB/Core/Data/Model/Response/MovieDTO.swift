//
//  MovieResponse.swift
//  TheMovieDB
//
//  Created by alfian on 04/07/24.
//

import Foundation

// MARK:
// For better naming convetion all API resmponse model will be use *DTO (Data Transfer Object)
public struct ListDTO<D: Codable>: Codable {
  let results: [D]

  public init(results: [D]) {
    self.results = results
  }
}

public struct MovieDTO: Codable {
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

  public init(id: Int?,
              title: String?,
              backdropPath: String?,
              posterPath: String?,
              overview: String?,
              voteAverage: Double?,
              voteCount: Int?,
              runtime: Int?,
              releaseDate: String?,
              casts: CastsDTO?,
              videos: ListDTO<VideosDTO>?) {
    self.id = id
    self.title = title
    self.backdropPath = backdropPath
    self.posterPath = posterPath
    self.overview = overview
    self.voteAverage = voteAverage
    self.voteCount = voteCount
    self.runtime = runtime
    self.releaseDate = releaseDate
    self.casts = casts
    self.videos = videos
  }
}

public struct CastsDTO: Codable {
  let cast: [CastDTO]

  public init(cast: [CastDTO]) {
    self.cast = cast
  }
}

public struct CastDTO: Codable {
  let id: Int?
  let name: String?
  let profilePath: String?

  public init(id: Int?, name: String?, profilePath: String?) {
    self.id = id
    self.name = name
    self.profilePath = profilePath
  }
}

public struct VideosDTO: Codable {
  let id: String?
  let site: String?
  let key: String?
  let type: String?

  public init(id: String?, site: String?, key: String?, type: String?) {
    self.id = id
    self.site = site
    self.key = key
    self.type = type
  }
}
