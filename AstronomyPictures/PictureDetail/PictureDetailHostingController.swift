//
//  PictureDetailHostingController.swift
//  AstronomyPictures
//
//  Created by myung hoon on 21/01/2024.
//

import UIKit
import SwiftUI

final class PictureDetailHostingController: UIViewController {
    private let vc = UIHostingController(rootView: PictureDetailView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHostingController()
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
