//
//  URLSessionClient.swift
//  TheMovieDB
//
//  Created by alfian on 06/07/24.
//

import Foundation
import Combine

// Base on Essential Developer HTTPClient just responsible to make sure the return is from HTTP
extension URLSession: HTTPClient {
  struct InvalidHTTPResponseError: Error {}

  func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
    return dataTaskPublisher(for: request)
      .tryMap { result in
        guard let httpResponse = result.response as? HTTPURLResponse else {
          throw InvalidHTTPResponseError()
        }
        return (result.data, httpResponse)
      }
      .eraseToAnyPublisher()
  }
}

// MARK:
// reference: https://youtu.be/Eo3WkbUV-fU?si=z24DZ0VDpPaow7q6
final class AuthenticatedHTTPClient: HTTPClient {
  private let client: HTTPClient
  private let apiKey: String

  init(client: HTTPClient = URLSession.shared, apiKey: String = APIConstans.apiKey) {
    self.client = client
    self.apiKey = apiKey
  }

  // MARK:
  // Here we can add Authorization for authenticated HTTP Request
  func publisher(request: URLRequest) -> AnyPublisher<(Data, HTTPURLResponse), Error> {
    var signedRequest = request
    signedRequest.url = appendApiKey(to: request.url)
    return client.publisher(request: signedRequest)
  }

  private func appendApiKey(to url: URL?) -> URL? {
    guard let url = url,
          var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
      return url
    }
    var queryItems = urlComponents.queryItems ?? []
    queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
    urlComponents.queryItems = queryItems
    return urlComponents.url
  }
}
