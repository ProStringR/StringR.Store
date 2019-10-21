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
    var orders: [Order]?
    var orderController = ControlReg.getOrderController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTableView()
        getData()
    }

    private func setupView() {
        self.view.backgroundColor = .white
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: Utility.getString(forKey: "orderViewController_CompletedOrdersHead")))
    }

    private func setupTableView() {
        self.completedOrdersTableView = LayoutController.getTableView(cellType: OrderCellGeneral.self, cellIdentifier: OrderCellGeneral.identifier, parentView: self.view)
        Layout.setupFullPageConstraints(forView: self.completedOrdersTableView, onParentView: self.view)

        self.completedOrdersTableView.dataSource = self
        // self.doneOrdersTableView.delegate = self
    }

    private func getData() {
        ShopSingleton.shared.getShop { (shop) in
            if let shop = shop {
                self.orderController.getCompletedOrders(orderIds: shop.orderIds) { (result) in
                    if let orders = result {
                        self.orders = orders
                        self.updateUI()
                    }
                }
            }
        }
    }

    private func updateUI() {
        DispatchQueue.main.async {
            //TODO: make the deliveryDate to deliveredDate
            self.orders =  self.orders?.sorted(by: {$0.deliveryDate < $1.deliveryDate})
            self.completedOrdersTableView.reloadData()
        }
    }
}

extension CompletedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let orders = self.orders {
            return orders.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let orders = self.orders else { return UITableViewCell() }

        // swiftlint:disable force_cast
        let cell = self.completedOrdersTableView.dequeueReusableCell(withIdentifier: OrderCellGeneral.identifier, for: indexPath) as! OrderCellGeneral
        // swiftlint:enable force_cast

        let currentOrder = orders[indexPath.row]

        cell.customerNameLabel.text = currentOrder.customer?.name
        cell.rightLabel.text = currentOrder.orderStatus.rawValue
        cell.statusIndicatorImageView.image = #imageLiteral(resourceName: "green_circle")

        cell.typeIndicator.image = currentOrder.racketString?.getImageIndication()

        cell.accessoryType = .detailButton
        cell.tintColor = .black

        return cell
    }
}
