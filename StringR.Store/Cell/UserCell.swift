//
//  UserCell.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 25/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class UserCell: UITableViewCell {

    static var identifier: String = "UserCell"

    weak var nameLabel: UILabel!
    weak var phoneNumberLabel: UILabel!
    weak var stackView: UIStackView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initializeElements()
        initializeStackView()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initializeElements() {
        self.nameLabel = LayoutController.getLabel(text: nil, parentView: self.contentView)

        self.phoneNumberLabel = LayoutController.getLabel(text: nil, parentView: self.contentView)
        self.phoneNumberLabel.textAlignment = .right
    }

    private func initializeStackView() {
        let content = [self.nameLabel, self.phoneNumberLabel]
        self.stackView = LayoutController.getStackView(content: content, orientation: .horizontal, parentView: self.contentView)
    }

    private func setConstraints() {
        Layout.centerVertically(on: self.stackView, withParent: self.contentView)
        Layout.addLeadingConstraint(on: self.stackView, to: self.contentView.leadingAnchor, by: Constant.bigOffset)
        Layout.addTrailingConstraint(on: self.stackView, to: self.contentView.trailingAnchor, by: Constant.bigOffset)
    }
}
