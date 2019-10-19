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

    weak var typeIndicator: UIImageView!
    weak var customerNameLabel: UILabel!
    weak var deliveryDateLabel: UILabel!
    weak var statusIndicatorImageView: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initializeCustomerNameLabel()
        initializeDeliveryDateLabel()
        initializeStatusIndicatorImageView()
        initializeTypeImageView()

        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initializeCustomerNameLabel() {
        self.customerNameLabel = LayoutController.getLabel(text: nil, parentView: self.contentView)
    }

    private func initializeDeliveryDateLabel() {
        self.deliveryDateLabel = LayoutController.getLabel(text: nil, parentView: self.contentView)
    }

    private func initializeStatusIndicatorImageView() {
        let color = UIImageView()
        color.contentMode = .scaleAspectFit
        self.statusIndicatorImageView = color

        self.contentView.addSubview(self.statusIndicatorImageView)
    }

    private func initializeTypeImageView() {
        let type = UIImageView()
        type.contentMode = .scaleAspectFit
        type.clipsToBounds = true
        self.typeIndicator = type

        self.contentView.addSubview(self.typeIndicator)
    }

    private func setupConstraints() {
        Layout.addTopConstraint(on: self.typeIndicator, to: self.contentView.topAnchor, by: Constant.bigOffset)
        Layout.addBottomConstraint(on: self.typeIndicator, to: self.contentView.bottomAnchor, by: Constant.bigOffset)
        Layout.addLeadingConstraint(on: self.typeIndicator, to: self.contentView.leadingAnchor)

        Layout.addTopConstraint(on: self.customerNameLabel, to: self.contentView.topAnchor)
        Layout.addBottomConstraint(on: self.customerNameLabel, to: self.contentView.bottomAnchor)
        Layout.addLeadingConstraint(on: self.customerNameLabel, to: self.typeIndicator.trailingAnchor)

        Layout.addTopConstraint(on: self.statusIndicatorImageView, to: self.contentView.topAnchor, by: Constant.bigOffset)
        Layout.addBottomConstraint(on: self.statusIndicatorImageView, to: self.contentView.bottomAnchor, by: Constant.bigOffset)
        Layout.addTrailingConstraint(on: self.statusIndicatorImageView, to: self.contentView.trailingAnchor)

        Layout.addTopConstraint(on: self.deliveryDateLabel, to: self.contentView.topAnchor)
        Layout.addBottomConstraint(on: self.deliveryDateLabel, to: self.contentView.bottomAnchor)
        Layout.addTrailingConstraint(on: self.deliveryDateLabel, to: self.statusIndicatorImageView.leadingAnchor)
    }
}
