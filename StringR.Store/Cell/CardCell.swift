//
//  CardCell.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 16/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class CardCell: UICollectionViewCell {
    static var identifier: String = "CardCell"

    weak var headerLabel: UILabel!
    weak var descriptionLabel: UILabel!
    weak var stackView: UIStackView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        initalizeStackView()
        initializeLabels()
        setConstraints()
        setShadow()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    private func initalizeStackView() {
        self.stackView = LayoutController.getStackView(content: [nil], orientation: .vertical, parentView: self.contentView)
    }

    private func initializeLabels() {
        let headerLabel = UILabel()
        let descriptionLabel = UILabel()

        self.headerLabel = headerLabel
        self.headerLabel.font = UIFont.boldSystemFont(ofSize: Constant.headerSize)

        self.descriptionLabel = descriptionLabel

        self.stackView.addArrangedSubview(self.headerLabel)
        self.stackView.addArrangedSubview(self.descriptionLabel)
    }

    private func setConstraints() {
        Layout.addTopConstraint(on: self.stackView, to: self.contentView.topAnchor, by: Constant.bigOffset)
        Layout.addLeadingConstraint(on: self.stackView, to: self.contentView.leadingAnchor)
        Layout.addBottomConstraint(on: self.stackView, to: self.contentView.bottomAnchor, by: Constant.bigOffset)
        Layout.addTrailingConstraint(on: self.stackView, to: self.contentView.trailingAnchor)
    }

    private func setShadow() {
        self.contentView.layer.cornerRadius = 2.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
