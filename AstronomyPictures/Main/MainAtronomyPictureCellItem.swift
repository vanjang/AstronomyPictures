//
//  MainAtronomyPictureCellItem.swift
//  AstronomyPictures
//
//  Created by myung hoon on 21/01/2024.
//

import Foundation
import Combine

struct MainAtronomyPictureCellItem: Hashable {
    let identifier = UUID()
    
    let url: URL
    let detailItem: DetailItem
    
    struct DetailItem {
        let url: URL
        let title: String
        let date: String
        let explanation: String
    }
    
    // Implement Hashable protocol
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: MainAtronomyPictureCellItem, rhs: MainAtronomyPictureCellItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
