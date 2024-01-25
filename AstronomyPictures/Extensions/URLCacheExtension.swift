//
//  URLCacheExtension.swift
//  AstronomyPictures
//
//  Created by myung hoon on 25/01/2024.
//

import Foundation

extension URLCache {
    static func configSharedCache(memory: Int, disk: Int) {
        let cache = URLCache(memoryCapacity: memory, diskCapacity: disk, diskPath: "apodApiCache")
        URLCache.shared = cache
    }
}
