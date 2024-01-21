//
//  MainViewController.swift
//  AstronomyPictures
//
//  Created by myung hoon on 21/01/2024.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<Section, MainAtronomyPictureCellItem>!
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviationBarAppearance()
        configureDataSource()
        fetchData()
    }

    override func loadView() {
        super.loadView()
        view = MainView()
    }

    private func configureNaviationBarAppearance() {
        title = "Astronomy Picture of Days"
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func configureDataSource() {
        guard let view = self.view as? MainView else { return }
        dataSource = UICollectionViewDiffableDataSource<Section, MainAtronomyPictureCellItem>(collectionView: view.collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAstronomyPictureCell.reuseIdentifier, for: indexPath) as? MainAstronomyPictureCell
            cell?.config(item: item)
               return cell
           }
       }

    private func fetchData() {
        viewModel.$items
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] items in
                    self?.updateCollectionView(with: items)
                  })
            .store(in: &cancellables)
    }
    
    private func updateCollectionView(with items: [MainAtronomyPictureCellItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MainAtronomyPictureCellItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    deinit {
        print("MainViewController deinit")
    }
}
