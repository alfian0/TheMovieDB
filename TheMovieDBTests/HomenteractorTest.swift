//
//  MovieInteractorTest.swift
//  TheMovieDBTests
//
//  Created by alfian on 17/07/24.
//

import XCTest
import TheMovieDBCore
import CoreData
import Combine
@testable import TheMovieDB

// swiftlint:disable all
final class MovieInteractorTest: XCTestCase {
    var session: URLSession!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        MockURLProtocol.requestHandler = nil
        session = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testGetNowPlayingMovies() {
        let mockData = createMockData()
        setupMockURLProtocol(with: mockData)
        
        let repository = createHomeInteractor()

        let expectation = self.expectation(description: "Fetching now playing movies")
        repository.getNowPlayingMovies()
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Request failed with error: \(error)")
                }
            } receiveValue: { movies in
                XCTAssertEqual(movies.count, 20)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGetUpcomingMovies() {
        let mockData = createMockData()
        setupMockURLProtocol(with: mockData)
        
        let repository = createHomeInteractor()

        let expectation = self.expectation(description: "Fetching upcoming movies movies")
        repository.getUpcomingMovies()
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Request failed with error: \(error)")
                }
            } receiveValue: { movies in
                XCTAssertEqual(movies.count, 20)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGetTopRatedMovies() {
        let mockData = createMockData()
        setupMockURLProtocol(with: mockData)
        
        let repository = createHomeInteractor()

        let expectation = self.expectation(description: "Fetching top rated movies")
        repository.getTopRatedMovies()
            .sink { completion in
                if case .failure(let error) = completion {
                    XCTFail("Request failed with error: \(error)")
                }
            } receiveValue: { movies in
                XCTAssertEqual(movies.count, 20)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    private func createMockData() -> Data {
      guard let url = Bundle.main.url(forResource: "now_playing", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
        return Data()
      }
      return data
    }
    
    private func setupMockURLProtocol(with mockData: Data) {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, mockData)
        }
    }
    
    private func createHomeInteractor() -> HomeInteractor {
        let client = AuthenticatedHTTPClient(client: session, apiKey: APIConstans.apiKey)
        let movieService = MovieServiceImpl(client: client)
        let coreDataClient = CoreDataClient(container: NSPersistentContainer(name: "MovieContainer"))
        let favoriteService = FavoriteServiceImp(with: coreDataClient)
        let repository = MovieRepositoryImpl(movieService: movieService, favoriteService: favoriteService)
        return HomeInteractor(repository: repository)
    }
}

class MockURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("No request handler provided.")
            return
        }
        
        do {
            let (response, data) = try handler(request)
            
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {}
}
// swiftlint:enable all
