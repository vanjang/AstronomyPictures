//
//  NetworkService.swift
//  AstronomyPictures
//
//  Created by myung hoon on 22/01/2024.
//

import Foundation
import Combine

struct NetworkService: NetworkServiceType {
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error> {
            guard let url = URL(string: "\(endpoint.baseURL)\(endpoint.path)") else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }

            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = endpoint.parameters

            guard let requestURL = components?.url else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }

            var request = URLRequest(url: requestURL)
            request.httpMethod = endpoint.method.rawValue

            if let headers = endpoint.headers {
                for (key, value) in headers {
                    request.addValue(value, forHTTPHeaderField: key)
                }
            }

            return URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: T.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
}
