//
//  MainViewModelTests.swift
//  AstronomyPicturesTests
//
//  Created by myung hoon on 24/01/2024.
//

import XCTest
import Combine
@testable import AstronomyPictures

enum TestError: Error {
    case test
}

final class MainViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    
    override func tearDownWithError() throws {
        cancellables.removeAll()
    }
    
    func testAPODFetching() {
        // Given
        let mockNetworkService = MockNetworkService(responseData: mockData)
        let paginationManager = PaginationManager()
        let logic = MainViewModelLogic(paginationManager: paginationManager)
        let viewModel = MainViewModel(networkService: mockNetworkService, logic: logic)
        
        // When
        let expectation = XCTestExpectation(description: "Fetch APODs")
        var receivedItems: [MainAstronomyPictureCellItem]?

        viewModel.$items
            .sink { items in
                receivedItems = items
                if !items.isEmpty {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Trigger viewWillAppear
        viewModel.fetch.send(())

        // Wait for expectations
        wait(for: [expectation], timeout: 2.0)

        // Then
        XCTAssertNotNil(receivedItems)
        XCTAssertFalse(receivedItems!.isEmpty)
        XCTAssert(viewModel.viewState == .populated)
    }
    
    func testViewStateWithoutError() {
        // Given
        let mockNetworkService = MockNetworkService(responseData: mockData)
        let paginationManager = PaginationManager()
        let logic = MainViewModelLogic(paginationManager: paginationManager)
        let viewModel = MainViewModel(networkService: mockNetworkService, logic: logic)
        let givenStates: [ViewState] = [.empty, .loading, .populated]
        
        // When
        let expectation = XCTestExpectation(description: "Fetch APODs")
        var viewStates: [ViewState] = []

        viewModel.$viewState
            .sink { state in
                viewStates.append(state)
                
                if viewStates.count > 2 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Trigger viewWillAppear
        viewModel.fetch.send(())

        // Wait for expectations
        wait(for: [expectation], timeout: 10.0)

        // Then
        XCTAssertTrue(viewStates == givenStates, "vs: \(viewStates), giv: \(givenStates)")
    }
    
    func testViewStateWithError() {
        // Given
        let mockNetworkService = MockNetworkService(responseError: TestError.test)
        let paginationManager = PaginationManager()
        let logic = MainViewModelLogic(paginationManager: paginationManager)
        let viewModel = MainViewModel(networkService: mockNetworkService, logic: logic)
        let givenStates: [ViewState] = [.empty, .loading, .error]
        
        // When
        let expectation = XCTestExpectation(description: "Fetch APODs")

        var viewStates: [ViewState] = []
        
        viewModel.$viewState
            .sink { state in
                viewStates.append(state)
                
                if viewStates.count == 3 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        // Trigger viewWillAppear
        viewModel.fetch.send(())

        // Wait for expectations
        wait(for: [expectation], timeout: 1.0)

        // Then
        XCTAssert(viewStates == givenStates, "Compare both the result viewStates: \(viewStates) and the given viewStates: \(givenStates)")
    }
    
    // Mock response data for APOD
    let mockData = """
        [
            {
                "date": "2024-01-24",
                "explanation": "placeholder",
                "hdurl": "https://apod.nasa.gov/apod/image/2401/EarthMoon_Artemis1Saunders_1600.jpg",
                "media_type": "image",
                "service_version": "v1",
                "title": "placeholder",
                "url": "https://apod.nasa.gov/apod/image/2401/EarthMoon_Artemis1Saunders_960.jpg"
            },
            {
                "date": "2024-01-23",
                "explanation": "placeholder",
                "hdurl": "https://apod.nasa.gov/apod/image/2401/EarthMoon_Artemis1Saunders_1600.jpg",
                "media_type": "image",
                "service_version": "v1",
                "title": "placeholder",
                "url": "https://apod.nasa.gov/apod/image/2401/EarthMoon_Artemis1Saunders_960.jpg"
            },
            {
                "date": "2024-01-22",
                "explanation": "placeholder",
                "hdurl": "https://apod.nasa.gov/apod/image/2401/EarthMoon_Artemis1Saunders_1600.mov",
                "media_type": "image",
                "service_version": "v1",
                "title": "placeholder",
                "url": "https://apod.nasa.gov/apod/image/2401/EarthMoon_Artemis1Saunders_960.mov"
            }
        ]
""".data(using: .utf8)!
    
}
