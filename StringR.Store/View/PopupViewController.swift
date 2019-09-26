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
        Layout.setupPopupViewContraints(forView: self.container, onParentView: self)
    }

    private func addViewControllerToContainer() {
        let viewControllerToPresent = self.viewController
        let navigationController = UINavigationController(rootViewController: viewControllerToPresent)
        self.addChild(navigationController)
        navigationController.didMove(toParent: self)

        container.addSubview(navigationController.view)

        Layout.setupFullPageConstraints(forView: navigationController.view, onParentView: container)
    }
}
