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

    static func getPopupView(viewControllerToPresent viewController: UIViewController) -> UIViewController {
        let popUp = PopupViewController(viewControllerToPresent: viewController)
        popUp.modalPresentationStyle = .overCurrentContext
        popUp.modalTransitionStyle = .crossDissolve

        return popUp
    }

    static func getSmallHeader(text: String, parentView: UIView) -> UILabel {
        let tempLabel = UILabel()
        tempLabel.text = text
        tempLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        parentView.addSubview(tempLabel)

        return tempLabel
    }

    static func getLabel(text: String, parentView: UIView) -> UILabel {
        let tempLabel = UILabel()
        tempLabel.text = text
        parentView.addSubview(tempLabel)

        return tempLabel
    }

    static func getButton(title: String, parentView: UIView) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        parentView.addSubview(button)

        return button
    }

    static func getStackView(content: [UIView?], orientation: NSLayoutConstraint.Axis, parentView: UIView) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = orientation
        stackView.alignment = .leading
        stackView.spacing = Constant.standardOffset
        stackView.distribution = .fillEqually

        for view in content {
            if let view = view {
                stackView.addArrangedSubview(view)
            }
        }

        parentView.addSubview(stackView)

        return stackView
    }
 }
