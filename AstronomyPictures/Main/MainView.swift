//
//  MainView.swift
//  AstronomyPictures
//
//  Created by myung hoon on 21/01/2024.
//

import UIKit

final class MainView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @UsesAutoLayout
    private var loadingIndicator: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(style: .medium)
        v.hidesWhenStopped = true
        v.color = .white
        return v
    }()
    
    @UsesAutoLayout
    var stateButton: UIButton = {
       let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    @UsesAutoLayout
    public var collectionView: UICollectionView = {
        let layout: UICollectionViewCompositionalLayout = {
            UICollectionViewCompositionalLayout { (sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                let numberOfItems = 4
                let size = (environment.container.effectiveContentSize.width - CGFloat(numberOfItems - 1)) / CGFloat(numberOfItems)
                let spacing: CGFloat = 1.0
                
                // Item
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(size), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                // Group
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(size))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(spacing)
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = spacing
                
                return section
            }
        }()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainAstronomyPictureCell.self, forCellWithReuseIdentifier: MainAstronomyPictureCell.reuseIdentifier)
        collectionView.accessibilityIdentifier = "MainCollectionViewId"
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    private func setUpUI() {
        addSubview(collectionView)
        addSubview(loadingIndicator)
        addSubview(stateButton)
        
        stateButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stateButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    public func updateViewState(_ state: ViewState) {
        switch state {
        case .empty:
            stateButton.isHidden = false
            stateButton.setTitle("No images found.\nTap to retry", for: .normal)
            loadingIndicator.stopAnimating()
            collectionView.isHidden = true
        case .error:
            stateButton.isHidden = false
            stateButton.setTitle("Error occurred.\nTap to retry", for: .normal)
            loadingIndicator.stopAnimating()
            collectionView.isHidden = true
        case .populated:
            stateButton.isHidden = true
            loadingIndicator.stopAnimating()
            collectionView.isHidden = false
        case .loading:
            stateButton.isHidden = true
            loadingIndicator.startAnimating()
            collectionView.isHidden = false
        }
    }
}
