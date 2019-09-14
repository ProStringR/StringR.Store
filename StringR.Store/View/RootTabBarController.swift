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
        let economyViewController = EconomyViewController()
        let storageViewController = StorageViewController()
        let teamViewController = TeamViewController()

        // create navigationControllers for the viewControllers that have more than one layer.
        let orderNavigationController = UINavigationController(rootViewController: orderViewController)
        let testRacketNavigationController = UINavigationController(rootViewController: testRacketViewController)

        // adding titles to the tabBar items
        orderNavigationController.tabBarItem.title = "Orders"
        testRacketNavigationController.tabBarItem.title = "Rackets"
        economyViewController.tabBarItem.title = "Economy"
        storageViewController.tabBarItem.title = "Storage"
        teamViewController.tabBarItem.title = "Team"

        // adding viewControllers to the tabBar
        viewControllers = [testRacketNavigationController, storageViewController, orderNavigationController, economyViewController, teamViewController]
    }
}
