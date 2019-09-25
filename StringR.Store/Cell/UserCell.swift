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
        setStackView()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initializeElements() {
        let name = UILabel()
        name.textAlignment = .left
        name.textColor = .black
        self.nameLabel = name

        let phone = UILabel()
        phone.textAlignment = .right
        phone.textColor = .black
        self.phoneNumberLabel = phone

        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.phoneNumberLabel)
    }

    private func setStackView() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constant.standardOffset
        stackView.distribution = .fillEqually
        self.stackView = stackView

        self.stackView.addArrangedSubview(self.nameLabel)
        self.stackView.addArrangedSubview(self.phoneNumberLabel)

        self.contentView.addSubview(self.stackView)
    }

    private func setConstraints() {
        Layout.centerVertically(on: self.stackView, withParent: self.contentView)
        Layout.addLeadingConstraint(on: self.stackView, to: self.contentView.leadingAnchor, by: Constant.bigOffset)
        Layout.addTrailingConstraint(on: self.stackView, to: self.contentView.trailingAnchor, by: Constant.bigOffset)
    }
}
