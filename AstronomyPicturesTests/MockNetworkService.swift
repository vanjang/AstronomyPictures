//
//  MockNetworkService.swift
//  AstronomyPictures
//
//  Created by myung hoon on 23/01/2024.
//

import Foundation
import Combine
@testable import AstronomyPictures

struct MockNetworkService: NetworkServiceType {
    var responseData: Data?
    var responseError: Error?

    init(responseData: Data? = nil, responseError: Error? = nil) {
        self.responseData = responseData
        self.responseError = responseError
    }

    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error> {
        if let responseError = responseError {
            return Fail(error: responseError).eraseToAnyPublisher()
        }
        
        guard let responseData = responseData else {
            fatalError("Test data should be provided to test when data exists")
        }

        do {
            let decodedData = try JSONDecoder().decode(T.self, from: responseData)
            return Just(decodedData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
