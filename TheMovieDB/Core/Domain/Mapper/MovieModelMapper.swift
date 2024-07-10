//
//  MovieModelMapper.swift
//  TheMovieDB
//
//  Created by alfian on 04/07/24.
//

import Foundation

final class MovieModelMapper {
  static func mapMovieResponseToEntity(input movieResponse: MovieDTO) -> MovieModel {
    return MovieModel(
      id: movieResponse.id ?? 0,
      title: movieResponse.title ?? "N/A",
      backdropURL: createURL(with: movieResponse.backdropPath),
      posterURL: createURL(with: movieResponse.posterPath),
      overview: movieResponse.overview ?? "N/A",
      rating: getRating(with: movieResponse.voteAverage),
      score: getScore(with: movieResponse.voteAverage),
      duration: getDuration(with: movieResponse.runtime),
      releaseDate: getReleaseYear(with: movieResponse.releaseDate),
      casts: getCasts(with: movieResponse.casts),
      videos: getVideos(wirh: movieResponse.videos),
      isFavorite: false
    )
  }

  static func mapFavoriteEntityToEntity(input entity: FavoriteEntity) -> MovieModel {
    return MovieModel(
      id: Int(entity.id),
      title: entity.title ?? "N/A",
      backdropURL: URL(string: APIConstans.placeholderImageURLString)!,
      posterURL: URL(string: APIConstans.placeholderImageURLString)!,
      overview: entity.overview ?? "N/A",
      rating: "",
      score: "",
      duration: "",
      releaseDate: "",
      casts: [],
      videos: [],
      isFavorite: true
    )
  }

  static func mapMovieResponsesToEntities(input moviesResponse: [MovieDTO]) -> [MovieModel] {
      return moviesResponse.map { mapMovieResponseToEntity(input: $0) }
  }

  static func mapFavoriteEntitiesToEntities(input entities: [FavoriteEntity]) -> [MovieModel] {
      return entities.map { mapFavoriteEntityToEntity(input: $0) }
  }

  private static func createURL(with path: String?) -> URL {
    let defaultURLString = APIConstans.placeholderImageURLString
    guard let path = path else { return URL(string: defaultURLString)! }
    return URL(string: "https://image.tmdb.org/t/p/w500\(path)")!
  }

  private static func getRating(with voteAverage: Double?) -> String {
    guard let voteAverage = voteAverage else { return "N/A" }
    let rating = Int(voteAverage)
    return String(repeating: "★", count: rating)
  }

  private static func getScore(with voteAverage: Double?) -> String {
    guard let ratingCount = voteAverage else { return "N/A" }
    return "\(Int(ratingCount))/10"
  }

  private static func getReleaseYear(with releaseDate: String?) -> String {
    guard let releaseDate = releaseDate,
          let date = Utils.dateFormatter.date(from: releaseDate) else {
        return "N/A"
    }
    return Utils.yearFormatter.string(from: date)
  }

  private static func getDuration(with runtime: Int?) -> String {
    guard let runtime = runtime, runtime > 0 else {
        return "N/A"
    }
    let hours = runtime / 60
    let minutes = runtime % 60
    return "\(hours)h \(minutes)m"
  }

  private static func getCasts(with casts: CastsDTO?) -> [CastModel] {
    return casts?.cast.map({ CastModel(id: $0.id ?? 0,
                                       name: $0.name ?? "",
                                       profileURL: createURL(with: $0.profilePath)) }) ?? []
  }

  private static func getVideos(wirh videos: ListDTO<VideosDTO>?) -> [VideoModel] {
    return videos?.results
      .filter({ $0.site == "YouTube" && $0.type == "Trailer" })
      .map({ VideoModel(site: $0.site ?? "",
                        key: $0.key ?? "",
                        thumbnailURL: URL(string: "https://img.youtube.com/vi/\($0.key ?? "")/0.jpg")!)}) ?? []
  }
}
