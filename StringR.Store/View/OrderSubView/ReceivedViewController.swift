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
        let tableView = LayoutController.getTableView(cellType: ReceivedOrderCell.self, cellIdentifier: ReceivedOrderCell.identifier)
        self.view.addSubview(tableView)
        self.receivedOrdersTableView = tableView

        Layout.setupFullPageConstraints(forView: self.receivedOrdersTableView, onParentView: self)

        self.receivedOrdersTableView.dataSource = self
//        self.receivedOrdersTableView.delegate = self
    }

    private func getData() {
        let order1 = Order(orderId: "lol",
                           customerId: "Jaafar Mahdi",
                           stringerId: "22/09/2020",
                           racketType: RacketType.TENNIS,
                           tensionVertical: 25,
                           tensionHorizontal: 25, stringId: "lol",
                           deliveryDate: 22222,
                           price: 22,
                           paid: true)

        let order2 = Order(orderId: "lol",
                           customerId: "Marcus Christiansen",
                           stringerId: "26/09/2019",
                           racketType: RacketType.TENNIS,
                           tensionVertical: 25,
                           tensionHorizontal: 25, stringId: "lol",
                           deliveryDate: 22222,
                           price: 22,
                           paid: false)

        self.orders = [Order]()
        self.orders?.append(order1)
        self.orders?.append(order2)
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
        cell.deliveryDateLabel.text = orders[indexPath.row].stringerId

        let image = orders[indexPath.row].paid ? #imageLiteral(resourceName: "green_circle") : #imageLiteral(resourceName: "red_circle")
        cell.statusIndicatorImageView.image = image

        cell.accessoryType = .disclosureIndicator
        cell.tintColor = .black

        return cell
    }
}
