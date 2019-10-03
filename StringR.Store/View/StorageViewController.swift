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
    var strings: [RacketString]?

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setupTableView()
        getStorageData()
        setupConstraints()
    }

    private func getStorageData() {
        // reload data in the tableView
        self.storageTableView.reloadData()
    }

    private func setLayout() {
        self.view.backgroundColor = .white
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: "generel_Storage"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(self.addAction))
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
        let popUp = LayoutController.getPopupView(viewControllerToPresent: AddStringStoragePopUpViewController())
        self.navigationController?.present(popUp, animated: true, completion: nil)
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

        switch currentString.stringPurpose {
        case .TENNIS:
            cell.typeIndicator.image = #imageLiteral(resourceName: "tennisball")
        case .BADMINTON:
            cell.typeIndicator.image = #imageLiteral(resourceName: "shuttlecock")
        case .SQUASH:
            cell.typeIndicator.image = #imageLiteral(resourceName: "squashball")
        }

        // Do this dynamic
        cell.colorIndicator.image = #imageLiteral(resourceName: "green_circle")

        cell.accessoryType = .disclosureIndicator
        cell.tintColor = .black

        // do the calculation of rackets remaining, and set the color indicator.
        return cell
    }
}

extension StorageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Do something
    }
}
