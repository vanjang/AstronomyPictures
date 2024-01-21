//
//  MainAtronomyPictureCellItem.swift
//  AstronomyPictures
//
//  Created by myung hoon on 21/01/2024.
//

import Foundation
import Combine

struct MainAtronomyPictureCellItem: Hashable {
    var identifier = UUID()
    let data: Data
    
    // Implement Hashable protocol
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: MainAtronomyPictureCellItem, rhs: MainAtronomyPictureCellItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
