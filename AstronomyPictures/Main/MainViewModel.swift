//
//  MainViewModel.swift
//  AstronomyPictures
//
//  Created by myung hoon on 21/01/2024.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    @Published var items: [MainAtronomyPictureCellItem] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        fetchData()
    }
    
    private func fetchData() {
        let url = URL(string: "https://picsum.photos/200/300")!
        
        // dummy data for UI testing
        URLSession.shared.dataTaskPublisher(for: url)
            .eraseToAnyPublisher()
            .map { e -> [MainAtronomyPictureCellItem] in
                [
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data),
                    MainAtronomyPictureCellItem(data: e.data)
                ]
            }
        .eraseToAnyPublisher()
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { _ in },
              receiveValue: { [weak self] items in
            self?.items = items
        })
        .store(in: &cancellables)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}

enum Section {
    case main
}
