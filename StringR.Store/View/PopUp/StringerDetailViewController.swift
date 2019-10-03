//
//  StringerDetailViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 25/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class StringerDetailViewController: UIViewController {

    weak var generelStackView: UIStackView!
    weak var infoStackView: UIStackView!
    weak var contactStackView: UIStackView!
    weak var otherInfoStackView: UIStackView!
    weak var orderStackView: UIStackView!

    weak var contactLabel: UILabel!
    weak var phoneLabel: UILabel!
    weak var mailLabel: UILabel!
    weak var address: UILabel!

    weak var infoLabel: UILabel!
    weak var birthdayLabel: UILabel!
    weak var preferredRacketTypeLabel: UILabel!

    weak var orderLabel: UILabel!
    weak var orderTableView: UITableView!

    weak var removeButton: UIButton!

    var currentStringer: Stringer?
    var stringerName: String?
    var activeOrders: [Order]?
    var strings: [RacketString]?

    override func viewDidLoad() {
        super.viewDidLoad()

        setGenerelLayout()

        if let name = stringerName {
            Layout.setupViewNavigationController(forView: self, withTitle: name)
        } else {
            Layout.setupViewNavigationController(forView: self, withTitle: "Name")
        }

        initRemoveButton()
        initializeLabels()
        setupTableView()
        setupContactViews()
        setupInfoViews()
        setupInfoStackView()
        setupOrderStackView()
        setupGenerelStackView()
        getActiveOrders()
        setConstaints()
    }

    private func setGenerelLayout() {
        self.view.backgroundColor = .white
        self.view.layer.cornerRadius = Constant.standardCornerRadius
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: Utility.getString(forKey: "common_close"), style: .plain, target: self, action: #selector(closeAction))
    }

    private func getActiveOrders() {
        // reload data in the tableView
        self.orderTableView.reloadData()
    }

    private func setupGenerelStackView() {
        let content = [self.infoStackView, self.orderStackView]
        self.generelStackView = LayoutController.getStackView(content: content, orientation: .vertical, parentView: self.view)
        self.generelStackView.alignment = .fill
        self.generelStackView.distribution = .fill
    }

    private func setupContactViews() {
        let content = [self.contactLabel, self.phoneLabel, self.mailLabel, self.address]
        self.contactStackView = LayoutController.getStackView(content: content, orientation: .vertical, parentView: self.view)
    }

    private func setupInfoViews() {
        let content = [self.infoLabel, self.birthdayLabel, self.preferredRacketTypeLabel]
        self.infoStackView = LayoutController.getStackView(content: content, orientation: .vertical, parentView: self.view)
    }

    private func setupInfoStackView() {
        let content = [self.contactStackView, self.infoStackView]
        self.infoStackView = LayoutController.getStackView(content: content, orientation: .horizontal, parentView: self.view)
    }

    private func setupOrderStackView() {
        let content = [self.orderLabel, self.orderTableView]
        self.orderStackView = LayoutController.getStackView(content: content, orientation: .vertical, parentView: self.view)
        self.orderStackView.distribution = .fill
    }

    private func setupTableView() {
        self.orderTableView = LayoutController.getTableView(cellType: StorageCell.self, cellIdentifier: StorageCell.identifier, parentView: self.view)

        self.orderTableView.delegate = self
        self.orderTableView.dataSource = self
    }

    private func initializeLabels() {
//        guard let stringer = self.currentStringer else { return }
//
//        self.phoneLabel = initLabel(text: stringer.phoneNumber)
//        self.mailLabel = initLabel(text: stringer.email)
//        // make a string that can cell where the stringer lives.
//        self.address = initLabel(text: stringer.address.city)
//        // make birthday to a string representation.
//        self.birthdayLabel = initLabel(text: String(stringer.birthday))
//        self.preferredRacketTypeLabel = initLabel(text: stringer.preferedRacketType.rawValue)

        self.phoneLabel = LayoutController.getLabel(text: "25 72 23 45", parentView: self.view)
        self.mailLabel = LayoutController.getLabel(text: "mac080497@gmail.com", parentView: self.view)
        self.address = LayoutController.getLabel(text: "Vimmelskaftet 13, Holbæk", parentView: self.view)
        self.birthdayLabel = LayoutController.getLabel(text: "08 / 04 - 97", parentView: self.view)
        self.preferredRacketTypeLabel = LayoutController.getLabel(text: "Tennis", parentView: self.view)

        self.contactLabel = LayoutController.getSmallHeader(text: "Contact", parentView: self.view)
        self.infoLabel = LayoutController.getSmallHeader(text: "Information", parentView: self.view)
        self.orderLabel = LayoutController.getSmallHeader(text: "Active orders", parentView: self.view)
    }

    private func initRemoveButton() {
        self.removeButton = LayoutController.getButton(title: Utility.getString(forKey: "stringerDetailViewController_removeStringerButtonText"), parentView: self.view)
        self.removeButton.addTarget(self, action: #selector(onRemoveStringerClicked(_:)), for: .touchUpInside)

        self.view.addSubview(self.removeButton)
    }

    private func setConstaints() {
        Layout.addBottomConstraint(on: self.removeButton, to: self.view.bottomAnchor, by: Constant.noOffset)
        Layout.addLeadingConstraint(on: self.removeButton, to: self.view.leadingAnchor, by: Constant.noOffset)
        Layout.addTrailingConstraint(on: self.removeButton, to: self.view.trailingAnchor, by: Constant.noOffset)

        Layout.addTopConstraint(on: self.generelStackView, to: self.view.safeAreaLayoutGuide.topAnchor)
        Layout.addLeadingConstraint(on: self.generelStackView, to: self.view.safeAreaLayoutGuide.leadingAnchor, by: Constant.hugeOffset)
        Layout.addTrailingConstraint(on: self.generelStackView, to: self.view.safeAreaLayoutGuide.trailingAnchor, by: Constant.hugeOffset)
        Layout.addBottomConstraint(on: self.generelStackView, to: self.removeButton.topAnchor)

        Layout.addTopConstraint(on: self.orderTableView, to: self.orderLabel.bottomAnchor)
        Layout.addTrailingConstraint(on: self.orderTableView, to: self.orderStackView.trailingAnchor)
    }

    @objc func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func onRemoveStringerClicked(_ sender: UIButton) {
        if sender === self.removeButton {
            print("Remove Stringer")
        }
    }
}

extension StringerDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let storage = self.strings {
            return storage.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let storage = self.strings else { return UITableViewCell() }

        // swiftlint:disable force_cast
        let cell = self.orderTableView.dequeueReusableCell(withIdentifier: StorageCell.identifier, for: indexPath) as! StorageCell
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

extension StringerDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
