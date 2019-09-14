//
//  OrderViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class OrderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hideNavigationBar()

        setLayout()
    }

    private func setLayout() {
        self.view.backgroundColor = .white
        let header = UILabel()
        view.addSubview(header)

        header.text = Utility.getString(forKey: "generel_Order")
        Layout.addHeadingLayout(on: header, withParent: view)
    }
}
