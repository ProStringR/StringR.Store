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

    override init(frame: CGRect) {
        super.init(frame: frame)

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

    private func initializeLabels() {
        let headerLabel = UILabel()
        let descriptionLabel = UILabel()

        self.headerLabel = headerLabel
        self.headerLabel.font = UIFont.boldSystemFont(ofSize: Constant.cardHeaderSize)

        self.descriptionLabel = descriptionLabel

        self.contentView.addSubview(self.headerLabel)
        self.contentView.addSubview(self.descriptionLabel)
    }

    private func setConstraints() {

        Layout.addTopConstraint(on: self.headerLabel, to: self.contentView.topAnchor, by: Constant.bigOffset)
        Layout.addLeadingConstraint(on: self.headerLabel, to: self.contentView.leadingAnchor, by: Constant.bigOffset)

        Layout.addTopConstraint(on: self.descriptionLabel, to: self.headerLabel.bottomAnchor)
        Layout.addLeadingConstraint(on: self.descriptionLabel, to: self.contentView.leadingAnchor, by: Constant.bigOffset)
    }

    private func setShadow() {
        self.contentView.layer.cornerRadius = 2.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)//CGSizeMake(0, 2.0);
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
