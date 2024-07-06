//
//  Request.swift
//  TheMovieDB
//
//  Created by alfian on 05/07/24.
//

import Foundation

protocol Request {
  var path: String { get }
  var method: HTTPMethod { get }
  var contentType: String { get }
  var body: [String: Any]? { get }
  var queryParams: [String: Any]? { get }
  var headers: [String: String]? { get }
  associatedtype ReturnType: Codable
}

extension Request {
  var method: HTTPMethod { return .get }
  var contentType: String { return ContentType.json.rawValue }
  var body: [String: Any]? { return nil }
  var queryParams: [String: Any]? { return nil }
  var headers: [String: String]? { return nil }

  func asURLRequest(baseURL: String = APIConstans.baseURL) -> URLRequest? {
    guard var urlComponents = URLComponents(string: baseURL) else { return nil }
    urlComponents.path = "\(urlComponents.path)\(path)"
    urlComponents.queryItems = addQueryItems(queryParams: queryParams)
    guard let finalURL = urlComponents.url else { return nil }
    var request = URLRequest(url: finalURL)
    request.httpMethod = method.rawValue
    request.httpBody = requestBodyFrom(params: body)
    request.allHTTPHeaderFields = headers
    request.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

    return request
  }

  func addQueryItems(queryParams: [String: Any]?) -> [URLQueryItem]? {
    guard let queryParams = queryParams else {
      return nil
    }

    return queryParams.map({ URLQueryItem(name: $0.key, value: "\($0.value)") })
  }

  private func requestBodyFrom(params: [String: Any]?) -> Data? {
    guard let params = params else { return nil }
    guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
      return nil
    }

    return httpBody
  }
}
