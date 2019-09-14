//
//  EconomyViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class EconomyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }

    private func setupLayout() {
        self.view.backgroundColor = .white
        let header = UILabel()
        view.addSubview(header)

        header.text = Utility.getString(forKey: "generel_Economy")
        Layout.addHeadingLayout(on: header, withParent: self.view)

    }
}
