//
//  PaginationManager.swift
//  AstronomyPictures
//
//  Created by myung hoon on 24/01/2024.
//

import Foundation

class PaginationManager {
    typealias Offset = (current: Int, next: Int)

    private var currentPage: Int
    private let pageSize: Int
    
    init(initialPage: Int = 0, pageSize: Int = 40) {
        self.currentPage = initialPage
        self.pageSize = pageSize
    }

    func getOffset() -> Offset {
        let current = currentPage == 0 ? 0 : currentPage - 1
        let offset = current - pageSize
        currentPage = offset
        return (current: current, next: offset)
    }
}
