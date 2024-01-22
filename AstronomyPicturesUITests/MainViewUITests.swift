//
//  MainViewUITests.swift
//  AstronomyPicturesUITests
//
//  Created by myung hoon on 21/01/2024.
//

import XCTest

final class MainViewUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNavigationTitle() throws {
        let navBar = app.navigationBars.element
        XCTAssert(navBar.exists)
        
        let title = "Astronomy Picture of Days"
        let navBarTitle = app.staticTexts[title]
        XCTAssert(navBarTitle.exists, "The navigationBar title should be \(title)")
    }
    
    func testCollectionViewRowCellCount() throws {
        let collectionView = app.collectionViews["MainCollectionViewId"]
        let cells = collectionView.cells
        let expectedItemsPerRow = 4
        XCTAssertEqual(cells.count % expectedItemsPerRow, 0, "The number of cells in each row should be \(expectedItemsPerRow)")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
