//
//  PicturesDetailUITests.swift
//  AstronomyPicturesUITests
//
//  Created by myung hoon on 22/01/2024.
//

import XCTest

final class PicturesDetailUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    private func presentPictureDetailView() throws {
        let collectionView = app.collectionViews["MainCollectionViewId"]
        collectionView.cells.firstMatch.tap()
    }
    
    func testAstronomyPictureDetailViewShowUp() throws {
        try presentPictureDetailView()
        
        let title = app.staticTexts["TitleDescriptionViewTitle"]
        let date = app.staticTexts["TitleDescriptionViewDate"]
        let explanation = app.staticTexts["TitleDescriptionViewExplanation"]
        
        XCTAssert(title.waitForExistence(timeout: 0.5))
        XCTAssert(date.waitForExistence(timeout: 0.5))
        XCTAssert(explanation.waitForExistence(timeout: 0.5))
    }
    
    func testAstronomyPictureDetailViewDismissed() throws {
        try presentPictureDetailView()
        
        let closeButton = app.buttons["PictureDetailViewCloseButton"]
        closeButton.tap()
        
        XCTAssert(!closeButton.waitForExistence(timeout: 0.5))
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
