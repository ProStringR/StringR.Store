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

    private var orderView: UINavigationController?
    private var testRacketView: UINavigationController?
    private var economyView: UINavigationController?
    private var storageView: UINavigationController?
    private var teamView: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        Utility.writeStringToSharedPref(withKey: Constant.shopId, value: "betaTest")

        setupNavigationControllers()
        setupTabBarItems()
        addNavigationControllersToTabBarController()

        // set order tab to be the selected tab.
        self.selectedIndex = 2
    }

    private func setupNavigationControllers() {
        self.orderView = UINavigationController(rootViewController: OrderViewController())
        self.testRacketView = UINavigationController(rootViewController: TestRacketViewController())
        self.economyView = UINavigationController(rootViewController: EconomyViewController())
        self.storageView = UINavigationController(rootViewController: StorageViewController())
        self.teamView = UINavigationController(rootViewController: TeamViewController())
    }

    private func setupTabBarItems() {
        self.orderView?.tabBarItem.title = Utility.getString(forKey: "generel_Order")
        self.testRacketView?.tabBarItem.title = Utility.getString(forKey: "generel_Racket")
        self.economyView?.tabBarItem.title = Utility.getString(forKey: "generel_Economy")
        self.storageView?.tabBarItem.title = Utility.getString(forKey: "generel_Storage")
        self.teamView?.tabBarItem.title = Utility.getString(forKey: "generel_Team")

        self.orderView?.tabBarItem.image = UIImage(named: "order_icon")
        self.testRacketView?.tabBarItem.image = UIImage(named: "racket_icon")
        self.economyView?.tabBarItem.image = UIImage(named: "economy_icon")
        self.storageView?.tabBarItem.image = UIImage(named: "storage_icon")
        self.teamView?.tabBarItem.image = UIImage(named: "team_icon")

        // setting layout for the tab bar
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .black
    }

    private func addNavigationControllersToTabBarController() {
        guard let orderView = self.orderView, let testRacketView = self.testRacketView, let economyView = self.economyView, let storageView = self.storageView, let teamView = self.teamView else {
            return
        }

        self.viewControllers = [testRacketView, storageView, orderView, economyView, teamView]
    }
}
