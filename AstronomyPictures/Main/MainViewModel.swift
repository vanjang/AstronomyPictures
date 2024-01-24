//
//  MainViewModel.swift
//  AstronomyPictures
//
//  Created by myung hoon on 21/01/2024.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    // Inputs
    let viewWillAppear = PassthroughSubject<Void, Never>()
    let didScroll = PassthroughSubject<Void, Never>()
    
    // Outputs
    @Published private(set) var items: [MainAstronomyPictureCellItem] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: Error? = nil
    
    init(networkService: NetworkServiceType, logic: MainViewModelLogic) {
        let useCase = APODUseCase(networkService: networkService)
        
        // loading stream
        Publishers.Merge3(viewWillAppear.eraseToAnyPublisher().map { _ in true },
                          didScroll.eraseToAnyPublisher().map { _ in true },
                          $items.eraseToAnyPublisher().dropFirst().map { _ in false }).eraseToAnyPublisher()
            .assign(to: &$isLoading)
        
        // APODs stream
        Publishers.Merge(viewWillAppear.eraseToAnyPublisher(),
                         didScroll.debounce(for: .milliseconds(1000), scheduler: DispatchQueue.main).eraseToAnyPublisher())
        .flatMap { _ -> AnyPublisher<[MainAstronomyPictureCellItem], Error> in
            useCase.fetchAPODs(endPoint: logic.getAPODEndPoint(method: .get))
                .receive(on: DispatchQueue.main)
                .compactMap { logic.getCellItems(with: $0) }
                .eraseToAnyPublisher()
        }
        .scan([]) { $0 + $1 }
        .catch { [weak self] error in
            self?.error = error
            return Just([MainAstronomyPictureCellItem]())
        }
        .assign(to: &$items)
    }
}
