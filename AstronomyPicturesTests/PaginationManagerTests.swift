//
//  PaginationManagerTests.swift
//  AstronomyPicturesTests
//
//  Created by myung hoon on 24/01/2024.
//

import XCTest
@testable import AstronomyPictures

final class PaginationManagerTests: XCTestCase {
    func testGetOffset() {
        // Given
        let paginationManager = PaginationManager(initialPage: 3, pageSize: 10)

        // When
        let result = paginationManager.getOffset()

        // Then
        XCTAssertEqual(result.current, 2)
        XCTAssertEqual(result.next, -8)
    }

    func testGetOffsetWithZeroCurrentPage() {
        // Given
        let paginationManager = PaginationManager(initialPage: 0, pageSize: 15)

        // When
        let result = paginationManager.getOffset()

        // Then
        XCTAssertEqual(result.current, 0)
        XCTAssertEqual(result.next, -15)
    }
}
