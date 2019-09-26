//
//  AddStringPopUpContainerViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 23/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class AddStringPopUpViewController: UIViewController {

    weak var container: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        setupContainer()
        addViewControllerToContainer()
    }

    private func setupContainer() {
        let container = UIView()
        self.view.addSubview(container)
        self.container = container

        // Constraints
        Layout.addTopConstraint(on: self.container, to: self.view.safeAreaLayoutGuide.topAnchor, by: 160)
        Layout.addBottomConstraint(on: self.container, to: self.view.safeAreaLayoutGuide.bottomAnchor, by: 160)
        Layout.addTrailingConstraint(on: self.container, to: self.view.safeAreaLayoutGuide.trailingAnchor, by: 74)
        Layout.addLeadingConstraint(on: self.container, to: self.view.safeAreaLayoutGuide.leadingAnchor, by: 74)
    }

    private func addViewControllerToContainer() {
        let addViewController = AddStringStoragePopUpViewController()
        let navigationController = UINavigationController(rootViewController: addViewController)
        addChild(navigationController)
        navigationController.didMove(toParent: self)

        container.addSubview(navigationController.view)

        // Constraints in the container
        Layout.addTopConstraint(on: navigationController.view, to: container.topAnchor)
        Layout.addBottomConstraint(on: navigationController.view, to: container.bottomAnchor)
        Layout.addLeadingConstraint(on: navigationController.view, to: container.leadingAnchor)
        Layout.addTrailingConstraint(on: navigationController.view, to: container.trailingAnchor)
    }
}
