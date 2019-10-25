//
//  SpecificOrderHistoryViewController.swift
//  StringR.Store
//
//  Created by Jaafar on 25/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import UIKit

class SpecificOrderHistoryViewController: UIViewController {

    weak var orderHistoryTabelView: UITableView!
    var orderHistory: [OrderHistory]?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTableView()
    }

    private func setupView() {
        self.view.backgroundColor = .white
        self.view.layer.cornerRadius = Constant.standardCornerRadius
        Layout.setupViewNavigationController(forView: self, withTitle: "Order History")
    }

    private func setupTableView() {
        self.orderHistoryTabelView = LayoutController.getTableView(cellType: TwoSidedTextCell.self, cellIdentifier: TwoSidedTextCell.identifier, parentView: self.view)
        Layout.setupFullPageConstraints(forView: self.orderHistoryTabelView, onParentView: self.view)

        self.orderHistoryTabelView.dataSource = self
    }
}

extension SpecificOrderHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let orderHistory = self.orderHistory {
            return orderHistory.count
        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let orderHistory = self.orderHistory else { return UITableViewCell() }

        // swiftlint:disable force_cast
        let cell = self.orderHistoryTabelView.dequeueReusableCell(withIdentifier: TwoSidedTextCell.identifier, for: indexPath) as! TwoSidedTextCell
        // swiftlint:enable force_cast

        let item = orderHistory[indexPath.row]

        let date = Utility.dateToString(date: Date.init(milliseconds: item.date))
        cell.leftLabel.text = "\(date)"
        cell.rightLabel.text = "\(item.orderStatus.rawValue) | \(item.paid ? Utility.getString(forKey: "common_paid") : Utility.getString(forKey: "common_notPaid"))"

        // not clickable
        cell.selectionStyle = .none

        return cell
    }
}
