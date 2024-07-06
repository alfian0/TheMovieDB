//
//  Bundle+Extension.swift
//  TheMovieDB
//
//  Created by alfian on 04/07/24.
//

import Foundation

extension Bundle {
  func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D {
    guard let url = self.url(forResource: filename, withExtension: "json") else {
      throw NSError(domain: "FileNotFound",
                    code: 404,
                    userInfo: [NSLocalizedDescriptionKey: "File \(filename).json not found in bundle."])
    }
    let data = try Data(contentsOf: url)
    let jsonDecoder = Utils.jsonDecoder
    let decodeModel = try jsonDecoder.decode(D.self, from: data)
    return decodeModel
  }
}
