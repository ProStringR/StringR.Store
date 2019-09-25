//
//  ReceivedOrderCell.swift
//  StringR.Store
//
//  Created by Jaafar on 25/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import UIKit

class ReceivedOrderCell: UITableViewCell {

    static var identifier: String = "ReceivedOrderCell"

    weak var customerNameLabel: UILabel!
    weak var deliveryDateLabel: UILabel!
    weak var statusIndicatorImageView: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initializeCustomerNameLabel()
        initializeDeliveryDateLabel()
        initializeStatusIndicatorImageView()

        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initializeCustomerNameLabel() {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        self.customerNameLabel = label

        self.contentView.addSubview(self.customerNameLabel)
    }

    private func initializeDeliveryDateLabel() {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        self.deliveryDateLabel = label

        self.contentView.addSubview(self.deliveryDateLabel)
    }

    private func initializeStatusIndicatorImageView() {
        let color = UIImageView()
        color.contentMode = .scaleAspectFit
        self.statusIndicatorImageView = color

        self.contentView.addSubview(self.statusIndicatorImageView)
    }

    private func setupConstraints() {
        Layout.addTopConstraint(on: self.customerNameLabel, to: self.contentView.topAnchor)
        Layout.addBottomConstraint(on: self.customerNameLabel, to: self.contentView.bottomAnchor)
        Layout.addLeadingConstraint(on: self.customerNameLabel, to: self.contentView.leadingAnchor)

        Layout.addTopConstraint(on: self.statusIndicatorImageView, to: self.contentView.topAnchor, by: Constant.bigOffset)
        Layout.addBottomConstraint(on: self.statusIndicatorImageView, to: self.contentView.bottomAnchor, by: Constant.bigOffset)
        Layout.addTrailingConstraint(on: self.statusIndicatorImageView, to: self.contentView.trailingAnchor)

        Layout.addTopConstraint(on: self.deliveryDateLabel, to: self.contentView.topAnchor)
        Layout.addBottomConstraint(on: self.deliveryDateLabel, to: self.contentView.bottomAnchor)
        Layout.addTrailingConstraint(on: self.deliveryDateLabel, to: self.statusIndicatorImageView.leadingAnchor)
    }
}
