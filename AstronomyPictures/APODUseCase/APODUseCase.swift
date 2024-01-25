//
//  APODUseCase.swift
//  AstronomyPictures
//
//  Created by myung hoon on 24/01/2024.
//

import Foundation
import Combine

final class APODUseCase {
    private let networkService: NetworkServiceType
    
    init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }
}

extension APODUseCase: APODUseCaseType {
    // A request to retrieve images in specified dates
    func fetchAPODs(endPoint: APODEndpoint) -> AnyPublisher<[APOD], Error> {
        networkService.request(endPoint)
            .receive(on: DispatchQueue.main)
            .compactMap { (apods: [APOD]) -> [APOD] in apods }
            .eraseToAnyPublisher()
    }
    
    // A request to retrieve an image on a specified date(not in use yet)
    func fetchAPOD(endPoint: APODEndpoint) -> AnyPublisher<APOD, Error> {
        networkService.request(endPoint)
            .receive(on: DispatchQueue.main)
            .compactMap { (apod: APOD) -> APOD in apod }
            .eraseToAnyPublisher()
    }
}
