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
    var searchCustomers: [Customer]?
    var customers: [Customer]?
    var customerController = ControlReg.getCustomerController
    var searchController: UISearchController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setGenerelLayout()
        setupTableView()
        setupSearchBar()
        getCustomers()
    }

    private func getCustomers() {
        customerController.getAllCustomers { (result) in
            if let customers = result {
                self.searchCustomers = customers
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: Utility.getString(forKey: "findCustomer_guest_barItem"), style: .plain, target: self, action: #selector(useGuestUser))
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

    private func setupSearchBar() {
        self.searchController = LayoutController.getSearchBar()
        self.searchController?.searchResultsUpdater = self
        self.searchController?.searchBar.delegate = self

        self.navigationItem.searchController = self.searchController
    }

    @objc func closeAction() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }

    @objc func useGuestUser() {
        let alert = UIAlertController(title: Utility.getString(forKey: "findCustomer_guest_head"), message: Utility.getString(forKey: "findCustomer_guest_body"), preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = Utility.getString(forKey: "findCustomer_guest_placeholder_name")
        }
        alert.addTextField { (textField) in
            textField.placeholder = Utility.getString(forKey: "findCustomer_guest_placeholder_phoneNumber")
            textField.keyboardType = .phonePad
        }
        alert.addTextField { (textField) in
            textField.placeholder = Utility.getString(forKey: "findCustomer_guest_placeholder_mail")
            textField.keyboardType = .emailAddress
        }

        alert.addAction(UIAlertAction(title: Utility.getString(forKey: "common_continue"), style: .default, handler: { [weak alert] (_) in
            let name = alert?.textFields?[0].text ?? Constant.emptyString
            let phoneNumber = alert?.textFields?[1].text ?? Constant.emptyString
            let mail = alert?.textFields?[2].text ?? Constant.emptyString

            let guest = Customer(userId: Utility.getUUID(), name: name, birthday: 0, email: mail, phoneNumber: phoneNumber, preferedStringType: .DEAULT, preferedTensionVertical: 0, prederedTensionHorizontal: 0)

            self.customerController.putCustomer(customer: guest) { (succes) in
                if succes {
                    self.delegate?.addCustomer(customer: guest)
                    self.closeAction()
                }
            }

        }))

        alert.addAction(UIAlertAction(title: Utility.getString(forKey: "common_cancel"), style: .cancel, handler: { [weak alert] (_) in
            alert?.dismiss(animated: true, completion: nil)
        }))

        // Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
}

extension FindCustomerViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }

        if searchText == Constant.emptyString {
            self.searchCustomers = self.customers
        } else {
            if let customers = self.customers {
                self.searchCustomers = customers.filter {
                    return $0.name.lowercased().contains(searchText.lowercased()) || $0.phoneNumber.lowercased().contains(searchText.lowercased()) || $0.email.lowercased().contains(searchText.lowercased())
                }
            }
        }
       self.customerTableView.reloadData()
    }
}

extension FindCustomerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let customers = self.searchCustomers else { return }

        self.delegate?.addCustomer(customer: customers[indexPath.row])
        self.closeAction()
    }
}

extension FindCustomerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let customers = self.searchCustomers else { return 0 }

        return customers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let customers = self.searchCustomers else { return UITableViewCell() }

        // swiftlint:disable force_cast
        let cell = self.customerTableView.dequeueReusableCell(withIdentifier: TwoSidedTextCell.identifier, for: indexPath) as! TwoSidedTextCell
        // swiftlint:enable force_cast

        let currentCustomer = customers[indexPath.row]

        cell.leftLabel.text = currentCustomer.name
        cell.rightLabel.text = currentCustomer.phoneNumber

        return cell
    }
}
