//
//  MovieInteractorTest.swift
//  TheMovieDBTests
//
//  Created by alfian on 17/07/24.
//

import XCTest
import CoreData
import Combine
import TheMovieDBCore
import TheMovieDBService
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
      guard let url = Bundle.theMovieDBService.url(forResource: "now_playing", withExtension: "json"),
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
      let url = Bundle.theMovieDBService.url(forResource: "MovieContainer", withExtension: "momd")!
      let managedObjectModel =  NSManagedObjectModel(contentsOf: url)!
      let container = NSPersistentContainer(name: "MovieContainer", managedObjectModel: managedObjectModel)
      let client = AuthenticatedHTTPClient(client: session, apiKey: APIConstans.apiKey)
      let movieService = MovieServiceImpl(client: client)
      let coreDataClient = CoreDataClient(container: container)
      let favoriteService = FavoriteServiceImp(with: coreDataClient)
      let repository = MovieRepositoryImpl(movieService: movieService, favoriteService: favoriteService)
      return HomeInteractor(repository: repository)
    }
}
// swiftlint:enable all
