//
//  APODUseCaseType.swift
//  AstronomyPictures
//
//  Created by myung hoon on 24/01/2024.
//

import Foundation
import Combine

// Blueprinting APOD API usage
protocol APODUseCaseType {
    func fetchAPODs(endPoint: APODEndpoint) -> AnyPublisher<[APOD], Error>
    func fetchAPOD(endPoint: APODEndpoint) -> AnyPublisher<APOD, Error>
}
