//
//  AddStringStoragePopUpViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 22/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class AddStringStoragePopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.backgroundColor = .clear
        view.isOpaque = false
        //setupGenerelLayout()
    }

    private func setupGenerelLayout() {
        view.backgroundColor = .clear

        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        view.addSubview(blurEffectView)
    }

    private func setupImage() {
        let image = #imageLiteral(resourceName: "storage_icon")
        let imageView = UIImageView()
        imageView.image = image

        self.view.addSubview(imageView)
        Layout.centerVertically(on: imageView, withParent: self.view)
        Layout.centerHorizontally(on: imageView, withParent: self.view)
    }
}
