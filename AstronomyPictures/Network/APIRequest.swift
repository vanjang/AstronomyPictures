//
//  APIRequest.swift
//  AstronomyPictures
//
//  Created by myung hoon on 22/01/2024.
//

import Foundation
import Combine

// Protocol defining the requirements for a network service
protocol APIRequest {
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error>
}
