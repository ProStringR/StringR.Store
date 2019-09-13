//
//  RootTabBarController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        let orderViewController = OrderViewController()
        let testRacketViewController = TestRacketViewController()
        let orderNavigationController = UINavigationController(rootViewController: orderViewController)

        orderViewController.tabBarItem.title = "Orders"
        testRacketViewController.tabBarItem.title = "Rackets"
        viewControllers = [orderViewController, testRacketViewController]
    }
}
