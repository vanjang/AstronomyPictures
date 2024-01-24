//
//  MainViewModelTests.swift
//  AstronomyPicturesTests
//
//  Created by myung hoon on 24/01/2024.
//

import XCTest
import Combine
@testable import AstronomyPictures

final class MainViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    
    func testViewModelInitialization() {
        // Given
        let mockNetworkService = MockNetworkService(responseData: mockData)
        let paginationManager = PaginationManager()
        let logic = MainViewModelLogic(paginationManager: paginationManager)
        let viewModel = MainViewModel(networkService: mockNetworkService, logic: logic)
        
        // When
        let expectation = XCTestExpectation(description: "ViewModel initialization")
        viewModel.$items
            .sink { items in
                // Then
                XCTAssertNotNil(viewModel.viewWillAppear)
                XCTAssertNotNil(viewModel.didScroll)
                XCTAssertNotNil(viewModel.isLoading)
                XCTAssertNil(viewModel.error)
                XCTAssertTrue(items.isEmpty)
                XCTAssertFalse(viewModel.isLoading)
                XCTAssertNil(viewModel.error)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        // Trigger viewWillAppear
        viewModel.viewWillAppear.send(())
        
        // Wait for expectations
        wait(for: [expectation], timeout: 1.0)
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
        viewModel.viewWillAppear.send(())

        // Wait for expectations
        wait(for: [expectation], timeout: 2.0)

        // Then
        XCTAssertNotNil(receivedItems)
        XCTAssertFalse(receivedItems!.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.error)
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
