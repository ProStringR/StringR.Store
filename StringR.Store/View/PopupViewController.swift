//
//  PopupViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 25/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class PopupViewController: UIViewController {

    weak var container: UIView!
    var viewController: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setupContainer()
        addViewControllerToContainer()
    }

    init(viewControllerToPresent viewController: UIViewController) {
        self.viewController = viewController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupContainer() {
        let container = UIView()
        self.view.addSubview(container)
        self.container = container

        // Constraints
        Layout.addTopConstraint(on: self.container, to: self.view.safeAreaLayoutGuide.topAnchor, by: Constant.popupTopBottom)
        Layout.addBottomConstraint(on: self.container, to: self.view.safeAreaLayoutGuide.bottomAnchor, by: Constant.popupTopBottom)
        Layout.addTrailingConstraint(on: self.container, to: self.view.safeAreaLayoutGuide.trailingAnchor, by: Constant.popupLeadingTrailing)
        Layout.addLeadingConstraint(on: self.container, to: self.view.safeAreaLayoutGuide.leadingAnchor, by: Constant.popupLeadingTrailing)
    }

    private func addViewControllerToContainer() {
        let viewControllerToPresent = self.viewController
        let navigationController = UINavigationController(rootViewController: viewControllerToPresent)
        self.addChild(navigationController)
        navigationController.didMove(toParent: self)

        container.addSubview(navigationController.view)

        // Constraints in the container
        Layout.addTopConstraint(on: navigationController.view, to: container.topAnchor)
        Layout.addBottomConstraint(on: navigationController.view, to: container.bottomAnchor)
        Layout.addLeadingConstraint(on: navigationController.view, to: container.leadingAnchor)
        Layout.addTrailingConstraint(on: navigationController.view, to: container.trailingAnchor)
    }
}
