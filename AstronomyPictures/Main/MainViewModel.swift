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
    let fetch = PassthroughSubject<Void, Never>()
    let didScroll = PassthroughSubject<Void, Never>()
    
    // Outputs
    @Published private(set) var items: [MainAstronomyPictureCellItem] = []
    @Published private(set) var viewState: ViewState = .empty
    
    init(networkService: NetworkServiceType, logic: MainViewModelLogic) {
        let useCase = APODUseCase(networkService: networkService)
        
        let error = CurrentValueSubject<Error?, Never>(nil)
        
        let didScroll = didScroll.debounce(for: .milliseconds(250), scheduler: DispatchQueue.main).share()
        
        let items = Publishers.Merge(fetch.eraseToAnyPublisher(),
                                     didScroll.eraseToAnyPublisher())
                    .flatMap { _ -> AnyPublisher<[MainAstronomyPictureCellItem], Error> in
                        useCase.fetchAPODs(endPoint: logic.getAPODEndPoint(method: .get))
                            .receive(on: DispatchQueue.main)
                            .compactMap { logic.getCellItems(with: $0) }
                            .eraseToAnyPublisher()
                    }
                    .scan([]) { $0 + $1 }
                    .catch { er in
                        error.send(er)
                        return Empty<[MainAstronomyPictureCellItem], Never>()
                    }
                    .share()
        
        // bindings
        items.assign(to: &$items)
     
        Publishers.Merge3(items.map { $0.isEmpty ? ViewState.empty : ViewState.populated},
                          Publishers.Merge(fetch, didScroll).eraseToAnyPublisher().map { _ in ViewState.loading },
                          error.compactMap { $0 }.map { _ in ViewState.error })
        .assign(to: &$viewState)
    }
}
