//
//  APODEndpoint.swift
//  AstronomyPictures
//
//  Created by myung hoon on 22/01/2024.
//

import Foundation

struct APODEndpoint: Endpoint {
    var baseURL: String { "https://api.nasa.gov/planetary" }
    var path: String { "/apod" }
    let method: HTTPMethod
    let parameters: [URLQueryItem]?
    let headers: [String: String]?
}
