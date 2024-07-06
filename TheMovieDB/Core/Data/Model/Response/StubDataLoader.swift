//
//  MovieResponse+Stub.swift
//  TheMovieDB
//
//  Created by alfian on 04/07/24.
//

import Foundation

class StubDataLoader {
    static func loadStubMovies() -> [MovieDTO] {
        do {
            let response: ListDTO<MovieDTO> = try Bundle.main.loadAndDecodeJSON(filename: "now_playing")
            return response.results
        } catch {
            print("Failed to load and decode JSON: \(error.localizedDescription)")
            return []
        }
    }

    static func loadStubMovie() -> MovieDTO? {
        do {
            let response: MovieDTO = try Bundle.main.loadAndDecodeJSON(filename: "movie_detail")
            return response
        } catch {
            print("Failed to load and decode JSON: \(error.localizedDescription)")
            return nil
        }
    }
}
