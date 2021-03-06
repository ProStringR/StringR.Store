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
    var orderController = ControlReg.getOrderController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTableView()
        getData()
    }

    private func setupView() {
        self.view.backgroundColor = .white
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: Utility.getString(forKey: "orderViewController_DoneOrdersHead")))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updateData))
    }

    private func setupTableView() {
        self.doneOrdersTableView = LayoutController.getTableView(cellType: OrderCellGeneral.self, cellIdentifier: OrderCellGeneral.identifier, parentView: self.view)
        Layout.setupFullPageConstraints(forView: self.doneOrdersTableView, onParentView: self.view)

        self.doneOrdersTableView.dataSource = self
         self.doneOrdersTableView.delegate = self
    }

    private func getData() {
        let spinner = LayoutController.getSpinner(forParent: self.view)
        self.showSpinner(withSpinner: spinner)
        ShopSingleton.shared.getShop { (shop) in
            if let shop = shop {
                self.orderController.getDoneOrders(orderIds: shop.orderIds) { (result) in
                    if let orders = result {
                        self.orders = orders
                        self.updateUI()
                    }
                    self.removeSpinner(forSpinner: spinner)
                }
            }
        }
    }

    private func updateUI() {
        DispatchQueue.main.async {
            //TODO: make the deliveryDate to doneDate
            self.orders =  self.orders?.sorted(by: {$0.deliveryDate < $1.deliveryDate})
            self.doneOrdersTableView.reloadData()
        }
    }

    @objc func updateData() {
        self.getData()
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
        let cell = self.doneOrdersTableView.dequeueReusableCell(withIdentifier: OrderCellGeneral.identifier, for: indexPath) as! OrderCellGeneral
        // swiftlint:enable force_cast

        let currentOrder = orders[indexPath.row]

        if let customer = currentOrder.customer {
            cell.customerNameLabel.text = "\(customer.name) | \(Utility.getLastChars(string: currentOrder.orderId, amount: 4))"
        } else {
            cell.customerNameLabel.text = Utility.getLastChars(string: currentOrder.orderId, amount: 4)
        }

        let paidText = currentOrder.paid ? "Paid" : "Not Paid"
        cell.rightLabel.text = "\(currentOrder.orderStatus.rawValue) | \(paidText)"

        cell.statusIndicatorImageView.image = currentOrder.paid ? #imageLiteral(resourceName: "green_circle") : #imageLiteral(resourceName: "yellow_circle")

        cell.typeIndicator.image = currentOrder.racketString?.getImageIndication()

        cell.accessoryType = .disclosureIndicator
        cell.tintColor = .black

        return cell
    }
}

extension DoneViewController: UITableViewDelegate {
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

extension DoneViewController: OrderModifierDelegate {
    func orderHasBeenModified(update: Bool) {
        if update {
            self.getData()
        }

        // show tabBar
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
}
