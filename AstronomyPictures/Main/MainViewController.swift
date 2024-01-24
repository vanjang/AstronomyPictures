//
//  MainViewController.swift
//  AstronomyPictures
//
//  Created by myung hoon on 21/01/2024.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<Section, MainAstronomyPictureCellItem>!
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel = MainViewModel(networkService: NetworkService(),
                                          logic: MainViewModelLogic(paginationManager: PaginationManager()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaviationBarAppearance()
        setUpDataSource()
        setUpCollectionView()
        bind()
    }

    override func loadView() {
        super.loadView()
        view = MainView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notifyViewWillAppear()
    }
    
    // setUp functions
    private func setUpCollectionView() {
        (view as? MainView)?.collectionView.delegate = self
    }

    private func setUpNaviationBarAppearance() {
        title = "Astronomy Pictures of Days"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
    }
    
    private func setUpDataSource() {
        guard let view = self.view as? MainView else { return }
        dataSource = UICollectionViewDiffableDataSource<Section, MainAstronomyPictureCellItem>(collectionView: view.collectionView) { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainAstronomyPictureCell.reuseIdentifier, for: indexPath) as? MainAstronomyPictureCell
            cell?.config(item: item)
               return cell
           }
       }
    
    // observers
    private func notifyViewWillAppear() {
        viewModel.viewWillAppear.send(())
    }
    
    private func notifyDidScrollReachEnd() {
        viewModel.didScroll.send(())
    }
    
    // binder
    private func bind() {
        // dataSource stream
        viewModel.$items
            .sink { [weak self] items in
                var snapshot = NSDiffableDataSourceSnapshot<Section, MainAstronomyPictureCellItem>()
                snapshot.appendSections([.main])
                snapshot.appendItems(items)
                self?.dataSource.apply(snapshot, animatingDifferences: true)
            }
            .store(in: &cancellables)
        
        // loading status stream
        viewModel.$isLoading
            .sink { [weak self] isLoading in
                (self?.view as? MainView)?.updateLoading(isLoading: isLoading)
            }
            .store(in: &cancellables)
        
        // error stream
        viewModel.$error
            .compactMap { $0 }
            .sink { [weak self] error in
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alert.addAction(ok)
                self?.present(alert, animated: true)
            }
            .store(in: &cancellables)
    }
    
    deinit {
        print("MainViewController deinit")
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let snapshot = dataSource.snapshot()
        guard snapshot.itemIdentifiers.indices.contains(indexPath.row) else { return }
        let item = snapshot.itemIdentifiers[indexPath.row]
        let vc = PictureDetailHostingController(item: item.detailItem)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height

        if offsetY > contentHeight - screenHeight {
            notifyDidScrollReachEnd()
        }
    }
}
