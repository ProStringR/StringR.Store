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

    weak var delegate: RemoveStringerDelegate?

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

    var currentStringer: StringerFb?
    var activeOrders: [OrderFb]?
    var strings: [RacketStringFb]?

    var orderController = ControlReg.getOrderController

    override func viewDidLoad() {
        super.viewDidLoad()

        setGenerelLayout()

        if let currentStringer = currentStringer {
            Layout.setupViewNavigationController(forView: self, withTitle: currentStringer.name)
        } else {
            Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: "stringerDetailViewController_noStringerFound"))
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
        if let stringer = self.currentStringer, let orderIds = stringer.orderIds {
            orderController.getRecievedOrders(orderIds: orderIds) { (result) in
                if let result = result {
                    self.activeOrders = result
                    self.updateUI()
                }
            }
        }
    }

    private func updateUI() {
        DispatchQueue.main.async {
            self.orderTableView.reloadData()
        }
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
        self.orderTableView = LayoutController.getTableView(cellType: OrderCellGeneral.self, cellIdentifier: OrderCellGeneral.identifier, parentView: self.view)

        self.orderTableView.delegate = self
        self.orderTableView.dataSource = self
    }

    private func initializeLabels() {
        guard let stringer = self.currentStringer else { return }

        self.phoneLabel = LayoutController.getLabel(text: stringer.phoneNumber, parentView: self.view)
        self.mailLabel = LayoutController.getLabel(text: stringer.email, parentView: self.view)
        self.preferredRacketTypeLabel = LayoutController.getLabel(text: stringer.preferedRacketType.rawValue, parentView: self.view)

        self.contactLabel = LayoutController.getSmallHeader(text: Utility.getString(forKey: "stringerDetailViewController_contactLabel"), parentView: self.view)
        self.infoLabel = LayoutController.getSmallHeader(text: Utility.getString(forKey: "stringerDetailViewController_informationLabel"), parentView: self.view)
        self.orderLabel = LayoutController.getSmallHeader(text: Utility.getString(forKey: "stringerDetailViewController_activeOrdersLabel"), parentView: self.view)
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
        self.delegate?.closeAction()
    }

    @objc func onRemoveStringerClicked(_ sender: UIButton) {
        guard let stringer = currentStringer else { return }
        if sender === self.removeButton {
            // make an alert
            let alert = LayoutController.getAlert(withTitle: Utility.getString(forKey: "stringerDetailViewController_removeStringerButtonText"), withMessage: Utility.getString(forKey: "stringerDetailViewController_alertBodyText", withArgs: [stringer.name]))
            alert.addAction(UIAlertAction(title: Utility.getString(forKey: "common_remove"), style: .destructive, handler: { (alert) in
                _ = alert
                // remove stringer from team
                self.delegate?.removeStringer(stringer: stringer)
            }))

            alert.addAction(UIAlertAction(title: Utility.getString(forKey: "common_cancel"), style: .default, handler: nil))
            // present the alert
            self.present(alert, animated: true)
        }
    }
}

extension StringerDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let orders = self.activeOrders {
            return orders.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let orders = self.activeOrders else { return UITableViewCell() }

        // swiftlint:disable force_cast
        let cell = self.orderTableView.dequeueReusableCell(withIdentifier: OrderCellGeneral.identifier, for: indexPath) as! OrderCellGeneral
        // swiftlint:enable force_cast

        let currentOrder = orders[indexPath.row]

        cell.customerNameLabel.text = currentOrder.customer?.name
        cell.rightLabel.text = Utility.dateToString(date: Date(milliseconds: currentOrder.deliveryDate))

        if currentOrder.daysToDeliver <= 1 {
            cell.statusIndicatorImageView.image = #imageLiteral(resourceName: "red_circle")
        } else if currentOrder.daysToDeliver <= 3 {
            cell.statusIndicatorImageView.image = #imageLiteral(resourceName: "yellow_circle")
        } else if currentOrder.daysToDeliver > 3 {
            cell.statusIndicatorImageView.image = #imageLiteral(resourceName: "green_circle")
        }

        cell.typeIndicator.image = currentOrder.racketString?.getImageIndication()

        // tableView is not clickable
        cell.selectionStyle = .none

        return cell
    }
}

extension StringerDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
