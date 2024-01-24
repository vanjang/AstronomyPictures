//
//  MainViewModelLogic.swift
//  AstronomyPictures
//
//  Created by myung hoon on 24/01/2024.
//

import Foundation

struct MainViewModelLogic {
    private let paginationManager: PaginationManager
    
    init(paginationManager: PaginationManager) {
        self.paginationManager = paginationManager
    }

    var apiKey: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "APOD API Key") as? String else {
            fatalError("API Key in either info.plist or config file is missing!")
        }
        return apiKey
    }
   
    func getAPODEndPoint(method: HTTPMethod) -> APODEndpoint {
        let offset = paginationManager.getOffset()
        
        let param: [URLQueryItem]? = {
            [URLQueryItem(name: "api_key", value: apiKey),
             URLQueryItem(name: "start_date", value: getDateString(before: offset.next)),
             URLQueryItem(name: "end_date", value: getDateString(before: offset.current))]
        }()
        
        let apodEndpoint = APODEndpoint(method: method, parameters: param, headers: nil)
        return apodEndpoint
    }
    
    func getCellItems(with apods: [APOD]) -> [MainAstronomyPictureCellItem] {
        apods
            .filter({ $0.url.hasSuffix(".jpg") || $0.url.hasSuffix(".jpeg") })
            .compactMap { apod -> MainAstronomyPictureCellItem? in
                guard let url = URL(string: apod.url) else { return nil }
                let hdUrl = URL(string: apod.hdurl ?? "") ?? url
                let detailItem = MainAstronomyPictureCellItem.DetailItem(url: hdUrl, title: apod.title, date: apod.date, explanation: apod.explanation)
                return MainAstronomyPictureCellItem(url: url, detailItem: detailItem)
            }
            .sorted { $0.detailItem.date > $1.detailItem.date }
    }
    
    func getDateString(before days: Int, to date: Date = Date()) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Calendar.current.date(byAdding: .day, value: days, to: date)
        return dateFormatter.string(from: date ?? Date())
    }
}
