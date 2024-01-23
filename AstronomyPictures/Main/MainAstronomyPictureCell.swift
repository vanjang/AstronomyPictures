//
//  MainAstronomyPictureCell.swift
//  AstronomyPictures
//
//  Created by myung hoon on 21/01/2024.
//

import UIKit
import Kingfisher

final class MainAstronomyPictureCell: UICollectionViewCell {
    static let reuseIdentifier = "MainAstronomyPictureCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        accessibilityIdentifier = "MainAstronomyPictureCell"
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    @UsesAutoLayout
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private func setUpUI() {
        contentView.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    public func config(item: MainAtronomyPictureCellItem) {
        imageView.kf.indicatorType = .activity
        
        imageView.kf.setImage(
            with: item.url,
            options: [
                .processor(DownsamplingImageProcessor(size: frame.size)),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.4)),
                .cacheOriginalImage
            ])
    }
}
