//
//  StorageCell.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 21/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class StorageCell: UITableViewCell {

    static var identifier: String = "StorageCell"

    weak var typeIndicator: UIImageView!
    weak var descriptionLabel: UILabel!
    weak var colorIndicator: UIImageView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initializeElements()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initializeElements() {
        let type = UIImageView()
        type.contentMode = .scaleAspectFit
        type.clipsToBounds = true
        self.typeIndicator = type

        self.descriptionLabel = LayoutController.getLabel(text: nil, parentView: self.contentView)

        let color = UIImageView()
        color.contentMode = .scaleAspectFit
        self.colorIndicator = color

        self.contentView.addSubview(self.typeIndicator)
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.colorIndicator)
    }

    private func setConstraints() {
        Layout.addTopConstraint(on: self.typeIndicator, to: self.contentView.topAnchor, by: Constant.bigOffset)
        Layout.addBottomConstraint(on: self.typeIndicator, to: self.contentView.bottomAnchor, by: Constant.bigOffset)
        Layout.addLeadingConstraint(on: self.typeIndicator, to: self.contentView.leadingAnchor)

        Layout.addLeadingConstraint(on: self.descriptionLabel, to: self.typeIndicator.trailingAnchor)
        Layout.centerVertically(on: self.descriptionLabel, withParent: self.typeIndicator)

        Layout.addTrailingConstraint(on: self.colorIndicator, to: self.contentView.trailingAnchor)
        Layout.addTopConstraint(on: self.colorIndicator, to: self.typeIndicator.topAnchor, by: 0)
        Layout.addBottomConstraint(on: self.colorIndicator, to: self.typeIndicator.bottomAnchor, by: 0)
    }
}
