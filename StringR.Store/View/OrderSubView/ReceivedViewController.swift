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
            self.orders =  self.orders?.sorted(by: {$0.deliveryDate < $1.deliveryDate})
            self.receivedOrdersTableView.reloadData()
        }
    }

    private func getData() {
        ShopSingleton.shared.getShop { (shop) in
            if let shop = shop {
                self.orderController.getRecievedOrders(shop: shop) { (result) in
                    self.orders = result
                    self.updateUI()
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

        let currentOrder = orders[indexPath.row]

        cell.customerNameLabel.text = currentOrder.customer?.name
        cell.deliveryDateLabel.text = Utility.dateToString(date: Date(milliseconds: currentOrder.deliveryDate))

        if currentOrder.daysToDeliver <= 1 {
            cell.statusIndicatorImageView.image = #imageLiteral(resourceName: "red_circle")
        } else if currentOrder.daysToDeliver <= 3 {
            cell.statusIndicatorImageView.image = #imageLiteral(resourceName: "yellow_circle")
        } else if currentOrder.daysToDeliver > 3 {
            cell.statusIndicatorImageView.image = #imageLiteral(resourceName: "green_circle")
        }

        if let string = currentOrder.racketString {
            switch string.stringPurpose {
            case .TENNIS:
                cell.typeIndicator.image = #imageLiteral(resourceName: "tennisball")
            case .BADMINTON:
                cell.typeIndicator.image = #imageLiteral(resourceName: "shuttlecock")
            case .SQUASH:
                cell.typeIndicator.image = #imageLiteral(resourceName: "squashball")
            }
        }

        cell.accessoryType = .disclosureIndicator
        cell.tintColor = .black

        return cell
    }
}
