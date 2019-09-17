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

    var data: [Int] = Array(0..<4)

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setupCollectionView()
        setupConstraints()
    }

    private func setLayout() {
        self.view.backgroundColor = .white
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: Utility.getString(forKey: "generel_Order")))
    }

    private func setupCollectionView() {
        let collectionView = LayoutController.generateCardCellCollectionView()
        self.view.addSubview(collectionView)
        self.collectionView = collectionView

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    private func setupConstraints() {
        Layout.setupVerticalCollectionViewConstraints(forCollectionView: self.collectionView, onParentView: self)
    }
}

extension OrderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        // swiftlint:enable force_cast
        cell.headerLabel.text = "Hello \(indexPath.item)"
        cell.descriptionLabel.text = "Description \(indexPath.item)"

        return cell
    }
}

extension OrderViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Clicked \(indexPath.row)")
    }
}
