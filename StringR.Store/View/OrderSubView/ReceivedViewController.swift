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
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: Utility.getString(forKey: "orderViewController_ReceivedOrdersHead")))
    }

    private func setupTableView() {
        self.receivedOrdersTableView = LayoutController.getTableView(cellType: ReceivedOrderCell.self, cellIdentifier: ReceivedOrderCell.identifier, parentView: self.view)
        Layout.setupFullPageConstraints(forView: self.receivedOrdersTableView, onParentView: self.view)

        self.receivedOrdersTableView.dataSource = self
//        self.receivedOrdersTableView.delegate = self
    }

    private func updateUI() {
        DispatchQueue.main.async {
            self.receivedOrdersTableView.reloadData()
        }
    }

    private func getData() {
        ShopSingleton.shared.getShop { (shop) in
            if let shop = shop {
                self.orderController.getRecievedOrders(shop: shop) { (result) in
                    if let result = result {
                        print(result.count)
                        self.orders = result
                        self.updateUI()
                    }
                }
            }
        }
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
        let cell = self.receivedOrdersTableView.dequeueReusableCell(withIdentifier: ReceivedOrderCell.identifier, for: indexPath) as! ReceivedOrderCell
        // swiftlint:enable force_cast

        cell.customerNameLabel.text = orders[indexPath.row].customerId
        cell.deliveryDateLabel.text = String(orders[indexPath.row].deliveryDate)

        let image = orders[indexPath.row].paid ? #imageLiteral(resourceName: "green_circle") : #imageLiteral(resourceName: "red_circle")
        cell.statusIndicatorImageView.image = image

        cell.accessoryType = .disclosureIndicator
        cell.tintColor = .black

        return cell
    }
}
