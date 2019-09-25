//
//  TwoSidedTextCell.swift
//  StringR.Store
//
//  Created by Jaafar on 25/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import UIKit

class TwoSidedTextCell: UITableViewCell {

    static var identifier: String = "TwoSidedTextCell"

    weak var leftLabel: UILabel!
    weak var rightLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initializeRightLabel()
        initializeLeftLabel()

        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initializeLeftLabel() {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        self.leftLabel = label

        self.contentView.addSubview(self.leftLabel)
    }

    private func initializeRightLabel() {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        self.rightLabel = label

        self.contentView.addSubview(self.rightLabel)
    }

    private func setupConstraints() {
        Layout.addTopConstraint(on: self.leftLabel, to: self.contentView.topAnchor)
        Layout.addBottomConstraint(on: self.leftLabel, to: self.contentView.bottomAnchor)
        Layout.addLeadingConstraint(on: self.leftLabel, to: self.contentView.leadingAnchor)

        Layout.addTopConstraint(on: self.rightLabel, to: self.contentView.topAnchor)
        Layout.addBottomConstraint(on: self.rightLabel, to: self.contentView.bottomAnchor)
        Layout.addTrailingConstraint(on: self.rightLabel, to: self.contentView.trailingAnchor)
    }
}
