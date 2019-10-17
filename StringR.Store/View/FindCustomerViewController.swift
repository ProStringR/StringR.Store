//
//  FindCustomerViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 15/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class FindCustomerViewController: UIViewController {

    weak var delegate: FindCustomerDelegate?

    weak var customerTableView: UITableView!
    var customers: [Customer]?
    var customerController = ControlReg.getCustomerController

    override func viewDidLoad() {
        super.viewDidLoad()
        setGenerelLayout()
        setupTableView()
        getCustomers()
    }

    private func getCustomers() {
        customerController.getAllCustomers { (result) in
            if let customers = result {
                self.customers = customers
                self.updateUI()
            } else {
                // TODO: Manage if something went wrong
            }
        }
    }

    private func updateUI() {
        DispatchQueue.main.async {
            self.customerTableView.reloadData()
        }
    }

    private func setGenerelLayout() {
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: "findCustomerViewController_header"))
        self.view.backgroundColor = .white
        self.view.layer.cornerRadius = Constant.standardCornerRadius
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: Utility.getString(forKey: "common_close"), style: .plain, target: self, action: #selector(closeAction))
    }

    private func setupTableView() {
        self.customerTableView = LayoutController.getTableView(cellType: TwoSidedTextCell.self, cellIdentifier: TwoSidedTextCell.identifier, parentView: self.view)
        Layout.addTopConstraint(on: self.customerTableView, to: self.view.safeAreaLayoutGuide.topAnchor)
        Layout.addLeadingConstraint(on: self.customerTableView, to: self.view.safeAreaLayoutGuide.leadingAnchor)
        Layout.addTrailingConstraint(on: self.customerTableView, to: self.view.safeAreaLayoutGuide.trailingAnchor)
        Layout.addBottomConstraint(on: self.customerTableView, to: self.view.safeAreaLayoutGuide.bottomAnchor)

        self.customerTableView.delegate = self
        self.customerTableView.dataSource = self
    }

    @objc func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension FindCustomerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let customers = self.customers else { return }

        self.delegate?.addCustomer(customer: customers[indexPath.row])
        self.closeAction()
    }
}

extension FindCustomerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let customers = self.customers else { return 0 }

        return customers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let customers = self.customers else { return UITableViewCell() }

        // swiftlint:disable force_cast
        let cell = self.customerTableView.dequeueReusableCell(withIdentifier: TwoSidedTextCell.identifier, for: indexPath) as! TwoSidedTextCell
        // swiftlint:enable force_cast

        let currentCustomer = customers[indexPath.row]

        cell.leftLabel.text = currentCustomer.name
        cell.rightLabel.text = currentCustomer.phoneNumber

        return cell
    }
}
