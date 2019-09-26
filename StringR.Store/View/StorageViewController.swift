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
        // call function to get Storage data for the shop
        let string1 = RacketString.init(brand: .TECNIFIBRE, modelName: "Black Code", thickness: 1.25, stringPurpose: .TENNIS, setUsed: 8)
        let string2 = RacketString.init(brand: .BABOLAT, modelName: "Blast", thickness: 1.25, stringPurpose: .BADMINTON, setUsed: 12)
        let string3 = RacketString.init(brand: .DUNLOP, modelName: "Egon", thickness: 1.11, stringPurpose: .SQUASH, setUsed: 12)

        // stored the data in the strings variable
        self.strings = [string1, string2, string3]

        // reload data in the tableView
        self.storageTableView.reloadData()
    }

    private func setLayout() {
        self.view.backgroundColor = .white
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: "generel_Storage"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(self.addAction))
    }

    private func setupTableView() {
        let tableView = LayoutController.getTableView(cellType: StorageCell.self, cellIdentifier: StorageCell.identifier)
        self.view.addSubview(tableView)
        self.storageTableView = tableView

        self.storageTableView.delegate = self
        self.storageTableView.dataSource = self
    }

    private func setupConstraints() {
        Layout.addTopConstraint(on: self.storageTableView, to: view.safeAreaLayoutGuide.topAnchor)
        Layout.addBottomConstraint(on: self.storageTableView, to: view.safeAreaLayoutGuide.bottomAnchor)
        Layout.addLeadingConstraint(on: self.storageTableView, to: view.safeAreaLayoutGuide.leadingAnchor)
        Layout.addTrailingConstraint(on: self.storageTableView, to: view.safeAreaLayoutGuide.trailingAnchor)
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
