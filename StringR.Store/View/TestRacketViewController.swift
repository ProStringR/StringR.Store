//
//  TestRacketViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class TestRacketViewController: CardCellViewController {

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
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: "generel_Racket"))
    }

    private func setupCollectionView() {
        let collectionView = LayoutController.getCollectionView(cellType: CardCell.self, cellIdentifier: CardCell.identifier)
        self.view.addSubview(collectionView)
        self.collectionView = collectionView

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    private func setupConstraints() {
        Layout.setupVerticalCollectionViewConstraints(forCollectionView: self.collectionView, onParentView: self)
    }

    private func intializeStringsForCollectionView() {
        self.list.append((Utility.getString(forKey: "racketViewController_RacketRentHead"), Utility.getString(forKey: "racketViewController_RacketRentDescription")))
        self.list.append((Utility.getString(forKey: "racketViewController_RacketRegisterHead"), Utility.getString(forKey: "racketViewController_RacketRegisterDescription")))
        self.list.append((Utility.getString(forKey: "racketViewController_racketReturnHead"), Utility.getString(forKey: "racketViewController_racketReturnDescription")))
        self.list.append((Utility.getString(forKey: "racketViewController_racketOverviewHead"), Utility.getString(forKey: "racketViewController_racketOverviewDescription")))
    }
}

extension TestRacketViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Clicked \(indexPath.row)")
    }
}

extension TestRacketViewController: UICollectionViewDataSource {
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
