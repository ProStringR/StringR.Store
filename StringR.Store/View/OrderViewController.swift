//
//  OrderViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class OrderViewController: CardCellViewController {

    weak var collectionView: UICollectionView!
    var list = [(header: String, description: String)]()

    override func viewDidLoad() {
        super.viewDidLoad()

        intializeStringsForCollectionView()
        setLayout()
        setupCollectionView()
        setupConstraints()
    }

    private func setLayout() {
        self.view.backgroundColor = .white
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: Utility.getString(forKey: "generel_Order")))
    }

    private func setupCollectionView() {
        let collectionView = LayoutController.getCollectionView(cellType: CardCell.self, cellIdentifier: CardCell.identifier)
        self.view.addSubview(collectionView)
        self.collectionView = collectionView

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    private func setupConstraints() {
        Layout.setupFullPageConstraints(forView: self.collectionView, onParentView: self.view)
    }

    private func intializeStringsForCollectionView() {
        self.list.append((Utility.getString(forKey: "orderViewController_OrderCreationHead"), Utility.getString(forKey: "orderViewController_OrderCreationDescription")))
        self.list.append((Utility.getString(forKey: "orderViewController_ReceivedOrdersHead"), Utility.getString(forKey: "orderViewController_ReceivedOrdersDescription")))
        self.list.append((Utility.getString(forKey: "orderViewController_DoneOrdersHead"), Utility.getString(forKey: "orderViewController_DoneOrdersDescription")))
        self.list.append((Utility.getString(forKey: "orderViewController_DeliveredOrdersHead"), Utility.getString(forKey: "orderViewController_DeliveredDescription")))
        self.list.append((Utility.getString(forKey: "orderViewController_CompletedOrdersHead"), Utility.getString(forKey: "orderViewController_CompletedDescription")))
    }
}

extension OrderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        // swiftlint:enable force_cast

        cell.headerLabel.text = self.list[indexPath.item].header
        cell.descriptionLabel.text = self.list[indexPath.item].description

        return cell
    }
}

extension OrderViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var nextViewController: UIViewController?

        switch indexPath.row {
        case 0:
            nextViewController = CreateOrderViewController()
        case 1:
            nextViewController = ReceivedViewController()
        case 2:
            nextViewController = DoneViewController()
        case 3:
            nextViewController = DeliveredViewController()
        case 4:
            nextViewController = CompletedViewController()
        default:
            print("Something went wrong during navigation from OrdersViewController")
        }

        if let nextViewController = nextViewController {
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
