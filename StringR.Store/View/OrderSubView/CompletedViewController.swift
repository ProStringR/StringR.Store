//
//  CompletedViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 19/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class CompletedViewController: UIViewController {

    weak var completedOrdersTableView: UITableView!

    var searchController: UISearchController?
    var searchOrders: [Order]?
    var orders: [Order]?
    var orderController = ControlReg.getOrderController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTableView()
        setupSearchBar()
        setupConstraints()
        getData()
    }

    private func setupView() {
        self.view.backgroundColor = .white
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: Utility.getString(forKey: "orderViewController_CompletedOrdersHead")))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updateData))
    }

    private func setupTableView() {
        self.completedOrdersTableView = LayoutController.getTableView(cellType: OrderCellGeneral.self, cellIdentifier: OrderCellGeneral.identifier, parentView: self.view)

        self.completedOrdersTableView.dataSource = self
         self.completedOrdersTableView.delegate = self
    }

    private func setupSearchBar() {
        self.searchController = LayoutController.getSearchBar()

        self.searchController?.searchResultsUpdater = self
        self.searchController?.searchBar.delegate = self

        self.navigationItem.searchController = self.searchController
    }

    private func setupConstraints() {
        Layout.setupFullPageConstraints(forView: self.completedOrdersTableView, onParentView: self.view)
    }

    private func getData() {
        let spinner = LayoutController.getSpinner(forParent: self.view)
        self.showSpinner(withSpinner: spinner)
        ShopSingleton.shared.getShop { (shop) in
            if let shop = shop {
                self.orderController.getCompletedOrders(orderIds: shop.orderIds) { (result) in
                    if let orders = result {
                        self.orders = orders
                        self.searchOrders = orders
                        self.updateUI()
                    }
                    self.removeSpinner(forSpinner: spinner)
                }
            }
        }
    }

    private func updateUI() {
        DispatchQueue.main.async {
            //TODO: make the deliveryDate to deliveredDate
            self.searchOrders =  self.searchOrders?.sorted(by: {$0.deliveryDate < $1.deliveryDate})
            self.completedOrdersTableView.reloadData()
        }
    }

    @objc func updateData() {
        self.getData()
    }
}

extension CompletedViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }

        if searchText == Constant.emptyString {
            self.searchOrders = orders
        } else {
            self.searchOrders = self.orders?.filter {
                if let customer = $0.customer {
                    return customer.name.lowercased().contains(searchText.lowercased()) || customer.phoneNumber.lowercased().contains(searchText.lowercased()) || customer.email.lowercased().contains(searchText.lowercased())
                } else {
                    return $0.orderId.lowercased().contains(searchText.lowercased())
                }
            }
        }
        self.completedOrdersTableView.reloadData()
    }
}

extension CompletedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let orders = self.searchOrders {
            return orders.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let orders = self.searchOrders else { return UITableViewCell() }

        // swiftlint:disable force_cast
        let cell = self.completedOrdersTableView.dequeueReusableCell(withIdentifier: OrderCellGeneral.identifier, for: indexPath) as! OrderCellGeneral
        // swiftlint:enable force_cast

        let currentOrder = orders[indexPath.row]

        if let customer = currentOrder.customer {
            cell.customerNameLabel.text = "\(customer.name) | \(Utility.getLastChars(string: currentOrder.orderId, amount: 4))"
        } else {
            cell.customerNameLabel.text = Utility.getLastChars(string: currentOrder.orderId, amount: 4)
        }

        cell.rightLabel.text = currentOrder.orderStatus.rawValue
        cell.statusIndicatorImageView.image = #imageLiteral(resourceName: "green_circle")

        cell.typeIndicator.image = currentOrder.racketString?.getImageIndication()

        cell.accessoryType = .disclosureIndicator
        cell.tintColor = .black

        return cell
    }
}

extension CompletedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let viewControllerToPresent = SpecificOrderViewController()
        viewControllerToPresent.delegate = self

        if let orders = self.orders {
            viewControllerToPresent.order = orders[indexPath.row]
        }

        let popUp = LayoutController.getPopupView(viewControllerToPresent: viewControllerToPresent)
        self.navigationController?.present(popUp, animated: true, completion: nil)

        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }
}

extension CompletedViewController: OrderModifierDelegate {
    func orderHasBeenModified(update: Bool) {
        if update {
            self.getData()
        }

        // show tabBar
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
}
