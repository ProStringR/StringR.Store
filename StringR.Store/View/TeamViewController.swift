//
//  TeamViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class TeamViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
    }

    private func setLayout() {
        self.view.backgroundColor = .white
        let header = UILabel()
        view.addSubview(header)

        header.text = Utility.getString(forKey: "generel_Team")
        Layout.addHeadingLayout(on: header, withParent: view)
    }
}
