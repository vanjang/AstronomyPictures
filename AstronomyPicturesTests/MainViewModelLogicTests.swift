//
//  MainViewModelLogicTests.swift
//  AstronomyPicturesTests
//
//  Created by myung hoon on 24/01/2024.
//

import XCTest
@testable import AstronomyPictures

/// Core logic tests for MainViewModelLogic
final class MainViewModelLogicTests: XCTestCase {
    private var logic: MainViewModelLogic!
    private var paginationManager: PaginationManager!
    
    override func setUpWithError() throws {
        logic = MainViewModelLogic(paginationManager: PaginationManager())
        paginationManager = PaginationManager()
    }
    
    override func tearDownWithError() throws {
        logic = nil
        paginationManager = nil
    }
    
    func testAPIKey() throws {
        XCTAssert(!logic.apiKey.isEmpty, "API Key should not be empty!")
    }
    
    func testGetAPODEndPoint() throws {
        // Given
        let pManager = PaginationManager(initialPage: 0, pageSize: 10)
        let endPointTestLogic = MainViewModelLogic(paginationManager: pManager)
        
        let httpMethod: HTTPMethod = .get
        let endPoint = endPointTestLogic.getAPODEndPoint(method: httpMethod)
        let parameters = endPoint.parameters
        
        // startDate is a date before n days
        let nextDate = parameters?.first(where: { $0.name == "start_date" })?.value as? String ?? ""
        let nextDateString = endPointTestLogic.getDateString(before: -10)
        XCTAssertEqual(nextDate, nextDateString)
        
        // endDate is a date starting a query
        let currentDate = parameters?.first(where: { $0.name == "end_date" })?.value as? String ?? ""
        let currentDateString = endPointTestLogic.getDateString(before: 0)
        XCTAssertEqual(currentDate, currentDateString)
        
        let apiKey = parameters?.first(where: { $0.name == "api_key" })?.value as? String ?? ""
        let apiKeyInlogic = endPointTestLogic.apiKey
        XCTAssertEqual(apiKey, apiKeyInlogic)
        
        let anotherManager = PaginationManager(initialPage: 0, pageSize: 40)
        let anotherLogic = MainViewModelLogic(paginationManager: anotherManager)
        let anotherEndPoint = anotherLogic.getAPODEndPoint(method: httpMethod)
        let anotherParameters = anotherEndPoint.parameters
        
        let anotherNextDate = anotherParameters?.first(where: { $0.name == "start_date" })?.value as? String ?? ""
        let anotherNextDateString = anotherLogic.getDateString(before: -40)
        XCTAssertEqual(anotherNextDate, anotherNextDateString)
        
        let anotherCurrentDate = anotherParameters?.first(where: { $0.name == "end_date" })?.value as? String ?? ""
        let anotherCurrentDateString = anotherLogic.getDateString(before: -0)
        XCTAssertEqual(anotherCurrentDate, anotherCurrentDateString)
    }
    
    func testCellItems() throws {
        // given
        // image urls
        let cat = "https://i.imgur.com/CzXTtJV.jpg"
        let dog = "https://i.imgur.com/OB0y6MR.jpg"
        let cheetah = "https://farm2.staticflickr.com/1533/26541536141_41abe98db3_z_d.jpeg"
        let bird = "https://farm4.staticflickr.com/3075/3168662394_7d7103de7d_z_d.jpg"
        
        // video urls
        let bunny = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        let elephant = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp"
        
        let catURL = URL(string: cat)
        let dogURL = URL(string: dog)
        let cheetahURL = URL(string: cheetah)
        let birdURL = URL(string: bird)
        
        // check the given sample URLs are valid
        XCTAssertNotNil(catURL)
        XCTAssertNotNil(dogURL)
        XCTAssertNotNil(cheetahURL)
        XCTAssertNotNil(birdURL)
        
        // falt url
        let falt = ""
        
        let allImageLinksValid = catURL != nil && dogURL != nil && cheetahURL != nil && birdURL != nil
        
        if allImageLinksValid {
            // when
            let apods: [APOD] = [
                APOD(copyright: nil, date: "2023-02-01", explanation: "explanation1", hdurl: cat, title: "title1", url: cat),
                APOD(copyright: nil, date: "2023-02-10", explanation: "explanation2", hdurl: bunny, title: "title2", url: bunny),
                APOD(copyright: nil, date: "2023-01-11", explanation: "explanation3", hdurl: dog, title: "title3", url: dog),
                APOD(copyright: nil, date: "2023-01-02", explanation: "explanation4", hdurl: cheetah, title: "title4", url: cheetah),
                APOD(copyright: nil, date: "2023-01-15", explanation: "explanation5", hdurl: elephant, title: "title5", url: elephant),
                APOD(copyright: nil, date: "2023-01-08", explanation: "explanation6", hdurl: falt, title: "title6", url: falt),
                APOD(copyright: nil, date: "2023-07-02", explanation: "explanation7", hdurl: bird, title: "title7", url: bird)
            ]
            
            let cellItems = logic.getCellItems(with: apods)
            
            // check cell items are correctly excluding urls without .jpg suffix
            XCTAssert(cellItems.count == 4)
            
            // then
            let testingCellItems: [MainAstronomyPictureCellItem] = [
                MainAstronomyPictureCellItem(url: cheetahURL!, detailItem: MainAstronomyPictureCellItem.DetailItem(url: cheetahURL!, title: "title4", date: "2023-01-02", explanation: "explanation4")),
                MainAstronomyPictureCellItem(url: dogURL!, detailItem: MainAstronomyPictureCellItem.DetailItem(url: dogURL!, title: "title3", date: "2023-01-11", explanation: "explanation3")),
                MainAstronomyPictureCellItem(url: catURL!, detailItem: MainAstronomyPictureCellItem.DetailItem(url: catURL!, title: "title1", date: "2023-02-01", explanation: "explanation1")),
                MainAstronomyPictureCellItem(url: birdURL!, detailItem: MainAstronomyPictureCellItem.DetailItem(url: birdURL!, title: "title7", date: "2023-07-02", explanation: "explanation7"))
            ]
            // check both items are NOT identical
            XCTAssertNotEqual(cellItems, testingCellItems)
            
            // due to cellItem's ID(for hashable) it is always NOT equal, so extracted detail items to compare
            let detailItems = cellItems.map { $0.detailItem }
            let sortedDetailItems = testingCellItems.sorted { $0.detailItem.date > $1.detailItem.date }.map { $0.detailItem }
            // check both detail items are identical
            XCTAssertEqual(detailItems, sortedDetailItems)
        } else {
            XCTSkip("test links are not valid any more - get another valid link!")
        }
        
    }
    
    func testDateString() throws {
        // Given
        let currentDate = Date()
        
        // When
        let result = logic.getDateString(before: -5, to: currentDate)
        
        // Then
        let expectedDate = Calendar.current.date(byAdding: .day, value: -5, to: currentDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let expectedDateString = dateFormatter.string(from: expectedDate ?? Date())
        
        XCTAssertEqual(result, expectedDateString)
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
