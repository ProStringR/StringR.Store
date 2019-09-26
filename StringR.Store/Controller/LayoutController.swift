//
//  LayoutController.swift
//  StringR.Store
//
//  Created by Jaafar on 16/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class LayoutController {
    static func getCollectionView<T: UICollectionViewCell>(cellType type: T.Type, cellIdentifier: String) -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(T.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false

        return collectionView
    }

    static func getTableView<T: UITableViewCell>(cellType type: T.Type, cellIdentifier: String) -> UITableView {
        let tableView = UITableView()
        tableView.rowHeight = Constant.tableViewRowHeight
        tableView.tableFooterView = UIView()
        tableView.register(T.self, forCellReuseIdentifier: cellIdentifier)

        return tableView
    }
}
