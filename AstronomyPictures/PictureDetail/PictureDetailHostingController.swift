//
//  PictureDetailHostingController.swift
//  AstronomyPictures
//
//  Created by myung hoon on 21/01/2024.
//

import UIKit
import SwiftUI

final class PictureDetailHostingController: UIViewController {
    private let vc: UIHostingController<PictureDetailView>!
    
    init(item: MainAstronomyPictureCellItem.DetailItem) {
        vc = UIHostingController(rootView: PictureDetailView(item: item))
        super.init(nibName: nil, bundle: nil)
        setUpHostingController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // to re-size view when rotating
        vc.view.frame = view.bounds
    }
    
    private func setUpHostingController() {
        addChild(vc)
        vc.view.backgroundColor = .black
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    deinit {
        print("PictureDetailHostingController deinit")
    }
}
