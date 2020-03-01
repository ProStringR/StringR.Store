//
//  StorageViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class StorageViewController: UIViewController {

    weak var storageTableView: UITableView!
    let storageController = ControlReg.getStorageController
    var strings: [RacketStringREST]?

    override func viewDidLoad() {
        super.viewDidLoad()

        Utility.fetchStaticData()
        setLayout()
        setupTableView()
        getStorageData()
        setupConstraints()
    }

    private func getStorageData() {
        let spinner = LayoutController.getSpinner(forParent: self.view)
        showSpinner(withSpinner: spinner)

        self.storageController.getStringsForShop(by: ShopSingleton.shared.shopId) { (racketStrings) in
            if let racketStrings = racketStrings {
                self.strings = racketStrings
                self.updateUI()
            }

            self.removeSpinner(forSpinner: spinner)
        }
    }

    private func updateUI() {
        DispatchQueue.main.async {
            self.storageTableView.reloadData()
        }
    }

    private func setLayout() {
        self.view.backgroundColor = .white
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: "generel_Storage"))
        let addButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(self.addAction))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updateData))
        self.navigationItem.rightBarButtonItems = [addButton, refreshButton]
    }

    private func setupTableView() {
        self.storageTableView = LayoutController.getTableView(cellType: StorageCell.self, cellIdentifier: StorageCell.identifier, parentView: self.view)

        self.storageTableView.delegate = self
        self.storageTableView.dataSource = self
    }

    private func setupConstraints() {
        Layout.setupFullPageConstraints(forView: self.storageTableView, onParentView: self.view)
    }

    @objc func addAction() {
        let viewControllerToPresent = AddStringToStorageViewController()
        viewControllerToPresent.delegate = self
        let popUp = LayoutController.getPopupView(viewControllerToPresent: viewControllerToPresent)
        self.navigationController?.present(popUp, animated: true, completion: nil)

        self.openAction()
    }

    @objc func updateData() {
        self.getStorageData()
    }
}

extension StorageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Do something
        if let storage = self.strings {
            return storage.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Do something
        guard let storage = self.strings else { return UITableViewCell() }

        // swiftlint:disable force_cast
        let cell = self.storageTableView.dequeueReusableCell(withIdentifier: StorageCell.identifier, for: indexPath) as! StorageCell
        // swiftlint:enable force_cast

        let currentString = storage[indexPath.row]

        cell.descriptionLabel.text = currentString.getDescription()

        if let purpose = currentString.stringPurpose {
            if purpose == RacketType.TENNIS.rawValue {
                cell.typeIndicator.image = #imageLiteral(resourceName: "tennisball")
            } else if purpose == RacketType.BADMINTON.rawValue {
                cell.typeIndicator.image = #imageLiteral(resourceName: "shuttlecock")
            } else if purpose == RacketType.SQUASH.rawValue {
                cell.typeIndicator.image = #imageLiteral(resourceName: "squashball")
            }
        }

        if let lengthRemaining = currentString.lengthInStock {
            if lengthRemaining <= 5 {
                cell.colorIndicator.image = #imageLiteral(resourceName: "red_circle")
            } else if lengthRemaining <= 10 {
                cell.colorIndicator.image = #imageLiteral(resourceName: "yellow_circle")
            } else if lengthRemaining > 10 {
                cell.colorIndicator.image = #imageLiteral(resourceName: "green_circle")
            }
        }

        cell.accessoryType = .disclosureIndicator
        cell.tintColor = .black

        // do the calculation of rackets remaining, and set the color indicator.
        return cell
    }
}

extension StorageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let viewControllerToPresent = SpecificStringInStorageViewController()
        viewControllerToPresent.delegate = self
        viewControllerToPresent.racketString = self.strings?[indexPath.row]
        let popUp = LayoutController.getPopupView(viewControllerToPresent: viewControllerToPresent)
        self.navigationController?.present(popUp, animated: true, completion: nil)

        self.openAction()
    }
}

extension StorageViewController: UpdateStorageDelegate {
    func removeString(string: RacketStringREST?) {
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                guard let racketString = string else { return }
                self.strings?.removeAll(where: {$0.stringId == racketString.stringId})
                self.updateUI()
                self.closeAction()
            }
        }
    }

    func addString(string: RacketStringREST?) {
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                self.updateData()

                self.updateUI()
                self.closeAction()
            }
        }
    }

    func closeAction() {
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }

    func openAction() {
        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }
}
