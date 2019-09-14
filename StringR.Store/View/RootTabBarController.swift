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

        // viewController creation
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

        // adding images to the tabBar items
        orderNavigationController.tabBarItem.image = UIImage(named: "order_icon")
        testRacketNavigationController.tabBarItem.image = UIImage(named: "racket_icon")
        economyViewController.tabBarItem.image = UIImage(named: "economy_icon")
        storageViewController.tabBarItem.image = UIImage(named: "storage_icon")
        teamViewController.tabBarItem.image = UIImage(named: "team_icon")

        // setting layout for the tab bar
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .black

        // adding viewControllers to the tabBar
        viewControllers = [testRacketNavigationController, storageViewController, orderNavigationController, economyViewController, teamViewController]

        // set order tab to be the selected tab.
        self.selectedIndex = 2
    }
}
