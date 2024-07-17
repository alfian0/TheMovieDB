//
//  MovieService.swift
//  TheMovieDBTests
//
//  Created by alfian on 17/07/24.
//

import XCTest
import CoreData
@testable import TheMovieDB

final class MovieModelMapperTest: XCTestCase {
  func testMapMovieResponseToEntity() {
    let movieResponse = MovieDTO(id: 1,
                                 title: "Test Movie",
                                 backdropPath: "/test_backdrop.jpg",
                                 posterPath: "/test_poster.jpg",
                                 overview: "Test overview",
                                 voteAverage: 8.5,
                                 voteCount: 120,
                                 runtime: 120,
                                 releaseDate: "2023-06-15",
                                 casts: CastsDTO(cast: [CastDTO(id: 1, name: "Actor 1", profilePath: "/profile1.jpg")]),
                                 videos: ListDTO<VideosDTO>(results: [
                                  VideosDTO(id: "1", site: "YouTube", key: "test_key", type: "Trailer")
                                 ]))

    let movieModel = MovieModelMapper.mapMovieResponseToEntity(input: movieResponse)

    XCTAssertEqual(movieModel.id, 1)
    XCTAssertEqual(movieModel.title, "Test Movie")
    XCTAssertEqual(movieModel.backdropURL, URL(string: "https://image.tmdb.org/t/p/w500/test_backdrop.jpg"))
    XCTAssertEqual(movieModel.posterURL, URL(string: "https://image.tmdb.org/t/p/w500/test_poster.jpg"))
    XCTAssertEqual(movieModel.overview, "Test overview")
    XCTAssertEqual(movieModel.rating, "★★★★★★★★")
    XCTAssertEqual(movieModel.score, "8/10")
    XCTAssertEqual(movieModel.duration, "2h 0m")
    XCTAssertEqual(movieModel.releaseDate, "2023")
    XCTAssertEqual(movieModel.casts.count, 1)
    XCTAssertEqual(movieModel.casts.first?.name, "Actor 1")
    XCTAssertEqual(movieModel.casts.first?.profileURL, URL(string: "https://image.tmdb.org/t/p/w500/profile1.jpg"))
    XCTAssertEqual(movieModel.videos.count, 1)
    XCTAssertEqual(movieModel.videos.first?.site, "YouTube")
    XCTAssertEqual(movieModel.videos.first?.key, "test_key")
    XCTAssertEqual(movieModel.videos.first?.thumbnailURL, URL(string: "https://img.youtube.com/vi/test_key/0.jpg"))
    XCTAssertEqual(movieModel.isFavorite, false)
  }

  func testMapFavoriteEntityToEntity() {
    let container = NSPersistentContainer(name: "MovieContainer")
    let favoriteEntity = FavoriteEntity(context: container.viewContext)
    favoriteEntity.id = 1
    favoriteEntity.title = "Favorite Movie"
    favoriteEntity.overview = "Favorite overview"

    let movieModel = MovieModelMapper.mapFavoriteEntityToEntity(input: favoriteEntity)

    XCTAssertEqual(movieModel.id, 1)
    XCTAssertEqual(movieModel.title, "Favorite Movie")
    XCTAssertEqual(movieModel.backdropURL, URL(string: APIConstans.placeholderImageURLString))
    XCTAssertEqual(movieModel.posterURL, URL(string: APIConstans.placeholderImageURLString))
    XCTAssertEqual(movieModel.overview, "Favorite overview")
    XCTAssertEqual(movieModel.rating, "")
    XCTAssertEqual(movieModel.score, "")
    XCTAssertEqual(movieModel.duration, "")
    XCTAssertEqual(movieModel.releaseDate, "")
    XCTAssertEqual(movieModel.casts.count, 0)
    XCTAssertEqual(movieModel.videos.count, 0)
    XCTAssertEqual(movieModel.isFavorite, true)
  }
}
