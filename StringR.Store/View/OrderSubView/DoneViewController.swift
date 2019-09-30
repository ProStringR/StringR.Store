//
//  DoneViewController.swift
//  StringR.Store
//
//  Created by Jaafar on 25/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import UIKit

class DoneViewController: UIViewController {

    weak var doneOrdersTableView: UITableView!
    var orders: [Order]?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTableView()
        getData()
    }

    private func setupView() {
        self.view.backgroundColor = .white
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: Utility.getString(forKey: "orderViewController_DoneOrdersHead")))
    }

    private func setupTableView() {
        self.doneOrdersTableView = LayoutController.getTableView(cellType: TwoSidedTextCell.self, cellIdentifier: TwoSidedTextCell.identifier, parentView: self.view)
        Layout.setupFullPageConstraints(forView: self.doneOrdersTableView, onParentView: self.view)

        self.doneOrdersTableView.dataSource = self
        // self.doneOrdersTableView.delegate = self
    }

    private func getData() {
        let order1 = Order(orderId: "lol",
                           customerId: "Jaafar Mahdi",
                           stringerId: "Picked up",
                           racketType: RacketType.TENNIS,
                           tensionVertical: 25,
                           tensionHorizontal: 25, stringId: "lol",
                           deliveryDate: 22222,
                           price: 22,
                           paid: true)

        let order2 = Order(orderId: "lol",
                           customerId: "Marcus Christiansen",
                           stringerId: "Ready for pick up",
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

extension DoneViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let orders = self.orders {
            return orders.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let orders = self.orders else { return UITableViewCell() }

        // swiftlint:disable force_cast
        let cell = self.doneOrdersTableView.dequeueReusableCell(withIdentifier: TwoSidedTextCell.identifier, for: indexPath) as! TwoSidedTextCell
        // swiftlint:enable force_cast

        cell.leftLabel.text = orders[indexPath.row].customerId
        cell.rightLabel.text = orders[indexPath.row].stringerId

        cell.tintColor = .black

        return cell
    }
}
