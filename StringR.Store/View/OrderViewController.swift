//
//  OrderViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class OrderViewController: UIViewController {

    weak var collectionView: UICollectionView!

    var data: [Int] = Array(0..<4)

    override func viewDidLoad() {
        super.viewDidLoad()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        self.view.addSubview(collectionView)
        // addding constraints to the collectionView
        Layout.addTopConstraint(on: collectionView, to: self.view.safeAreaLayoutGuide.topAnchor)
        Layout.addBottomConstraint(on: collectionView, to: self.view.safeAreaLayoutGuide.bottomAnchor)
        Layout.addLeadingConstraint(on: collectionView, to: self.view.safeAreaLayoutGuide.leadingAnchor)
        Layout.addTrailingConstraint(on: collectionView, to: self.view.safeAreaLayoutGuide.trailingAnchor)

        self.collectionView = collectionView

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.identifier)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .white
        self.collectionView.showsVerticalScrollIndicator = false

        setLayout()
    }

    private func setLayout() {
        self.view.backgroundColor = .white
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: Utility.getString(forKey: "generel_Order")))
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

extension OrderViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Clicked \(indexPath.row)")
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.4) {
            if let cell = collectionView.cellForItem(at: indexPath) as? CardCell {
                cell.transform = .init(scaleX: 0.95, y: 0.95)
                cell.contentView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.4) {
            if let cell = collectionView.cellForItem(at: indexPath) as? CardCell {
                cell.transform = .identity
                cell.contentView.backgroundColor = .white
            }
        }
    }
}

extension OrderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width-Constant.bigOffset, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constant.bigOffset, left: 0, bottom: Constant.bigOffset, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2 * Constant.bigOffset
    }
}
