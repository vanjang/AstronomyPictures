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
        setUpCollectionView()
        fetchData()
    }

    override func loadView() {
        super.loadView()
        view = MainView()
    }
    
    private func setUpCollectionView() {
        (view as? MainView)?.collectionView.delegate = self
    }

    private func configureNaviationBarAppearance() {
        title = "Astronomy Pictures of Days"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
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

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PictureDetailHostingController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
}
