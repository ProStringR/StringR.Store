//
//  ReceivedViewController.swift
//  StringR.Store
//
//  Created by Jaafar on 25/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import UIKit

class ReceivedViewController: UIViewController {

    weak var receivedOrdersTableView: UITableView!
    var orders: [OrderREST]?
    var orderController = ControlReg.getOrderController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTableView()
        getData()
    }

    private func setupView() {
        self.view.backgroundColor = .white
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: Utility.getString(forKey: "orderViewController_ReceivedOrdersHead")))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updateData))
    }

    private func setupTableView() {
        self.receivedOrdersTableView = LayoutController.getTableView(cellType: OrderCellGeneral.self, cellIdentifier: OrderCellGeneral.identifier, parentView: self.view)
        Layout.setupFullPageConstraints(forView: self.receivedOrdersTableView, onParentView: self.view)

        self.receivedOrdersTableView.dataSource = self
        self.receivedOrdersTableView.delegate = self
    }

    private func updateUI() {
        DispatchQueue.main.async {
            self.orders =  self.orders?.sorted(by: {$0.deliveryDate < $1.deliveryDate})
            self.receivedOrdersTableView.reloadData()
        }
    }

    private func getData() {
        let spinner = LayoutController.getSpinner(forParent: self.view)
        self.showSpinner(withSpinner: spinner)
        self.orderController.getAllOrdersWithStatus(shopId: ShopSingleton.shared.shopId, withStatus: 0) { (orders) in
            if let orders = orders {
                self.orders = orders
            }

            self.updateUI()
            self.removeSpinner(forSpinner: spinner)
        }
    }

    @objc func updateData() {
        self.getData()
    }
}

extension ReceivedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let orders = self.orders {
            return orders.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let orders = self.orders else { return UITableViewCell() }

        // swiftlint:disable force_cast
        let cell = self.receivedOrdersTableView.dequeueReusableCell(withIdentifier: OrderCellGeneral.identifier, for: indexPath) as! OrderCellGeneral
        // swiftlint:enable force_cast

        let currentOrder = orders[indexPath.row]

        cell.customerNameLabel.text = currentOrder.customer.firstName

        cell.rightLabel.text = Utility.dateToString(date: Date(milliseconds: currentOrder.deliveryDate))

        if currentOrder.daysToDeliver <= 1 {
            cell.statusIndicatorImageView.image = #imageLiteral(resourceName: "red_circle")
        } else if currentOrder.daysToDeliver <= 3 {
            cell.statusIndicatorImageView.image = #imageLiteral(resourceName: "yellow_circle")
        } else if currentOrder.daysToDeliver > 3 {
            cell.statusIndicatorImageView.image = #imageLiteral(resourceName: "green_circle")
        }

        cell.typeIndicator.image = currentOrder.racketString.getImageIndication()

        cell.accessoryType = .disclosureIndicator
        cell.tintColor = .black

        return cell
    }
}

extension ReceivedViewController: UITableViewDelegate {
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

extension ReceivedViewController: OrderModifierDelegate {
    func orderHasBeenModified(update: Bool) {
        if update {
            self.getData()
        }

        // show tabBar
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
}
