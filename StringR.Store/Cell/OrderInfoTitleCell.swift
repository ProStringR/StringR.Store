//
//  OrderInfoTitleCell.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 20/12/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class OrderInfoTitleCell: UITableViewCell {

    static var identifier: String = "OrderInfoTitleCell"

    weak var leftLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeLeftLabel()

        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initializeLeftLabel() {
        self.leftLabel = LayoutController.getLabel(text: nil, parentView: self.contentView)
    }

    private func setupConstraints() {
        Layout.addTopConstraint(on: self.leftLabel, to: self.contentView.topAnchor)
        Layout.addBottomConstraint(on: self.leftLabel, to: self.contentView.bottomAnchor)
        Layout.addLeadingConstraint(on: self.leftLabel, to: self.contentView.leadingAnchor)
    }
}
