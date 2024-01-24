//
//  APODUseCaseType.swift
//  AstronomyPictures
//
//  Created by myung hoon on 24/01/2024.
//

import Foundation
import Combine

// Blueprinting the conformances of Astronomy Picture Of the Day API usage
protocol APODUseCaseType {
    func fetchAPODs(endPoint: APODEndpoint) -> AnyPublisher<[APOD], Error>
    func fetchAPOD(endPoint: APODEndpoint) -> AnyPublisher<APOD, Error>
}
