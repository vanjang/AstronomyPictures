//
//  MainAstronomyPictureCellItem.swift
//  AstronomyPictures
//
//  Created by myung hoon on 21/01/2024.
//

import Foundation
import Combine

struct MainAstronomyPictureCellItem: Hashable {
    let identifier = UUID()
    
    let url: URL
    let detailItem: DetailItem
    
    struct DetailItem: Equatable {
        let url: URL
        let title: String
        let date: String
        let explanation: String
    }
    
    // Implement Hashable protocol
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: MainAstronomyPictureCellItem, rhs: MainAstronomyPictureCellItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
