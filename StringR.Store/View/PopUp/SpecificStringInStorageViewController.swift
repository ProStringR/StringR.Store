//
//  SpecificStringInStorageViewController.swift
//  StringR.Store
//
//  Created by Jaafar on 18/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import UIKit

class SpecificStringInStorageViewController: UIViewController {

    weak var brandTitle: UILabel!
    weak var brand: UILabel!
    weak var modelTitle: UILabel!
    weak var model: UILabel!
    weak var typeTitle: UILabel!
    weak var type: UILabel!
    weak var colorTitle: UILabel!
    weak var color: UILabel!
    weak var purposeTitle: UILabel!
    weak var purpose: UILabel!
    weak var thicknessTitle: UILabel!
    weak var thickness: UILabel!
    weak var lengthRemainingTitle: UILabel!
    weak var lengthRemaining: UILabel!
    weak var priceTitle: UILabel!
    weak var price: UILabel!

    weak var lengthInput: UITextField!
    weak var priceInput: UITextField!
    weak var dateInput: UITextField!

    weak var additionButton: UIButton!

    weak var topHeaderStackView: UIStackView!
    weak var topValueStackView: UIStackView!
    weak var bottomHeaderStackView: UIStackView!
    weak var bottomValueStackView: UIStackView!
    weak var additionStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLabels()
        setupStringAdditionFields()
        generateTopHeaderStackView()
        generateTopValueStackView()
        generateBottomHeaderStackView()
        generateBottomValueStackView()
        generateAdditionStackView()
        setupConstraints()
    }

    private func setupView() {
        self.view.backgroundColor = .white
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: Utility.getString(forKey: "generel_Order")))
        self.view.layer.cornerRadius = Constant.standardCornerRadius
        self.navigationController?.hideNavigationBar()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAction))
    }

    private func setupLabels() {
        brandTitle = LayoutController.getLabel(text: "Brand", parentView: self.view)
        brandTitle.font = UIFont.boldSystemFont(ofSize: Constant.cardHeaderSize)
        brand = LayoutController.getLabel(text: "Babolat", parentView: self.view)

        modelTitle = LayoutController.getLabel(text: "Model", parentView: self.view)
        modelTitle.font = UIFont.boldSystemFont(ofSize: Constant.cardHeaderSize)
        model = LayoutController.getLabel(text: "Rafa", parentView: self.view)

        typeTitle = LayoutController.getLabel(text: "Type", parentView: self.view)
        typeTitle.font = UIFont.boldSystemFont(ofSize: Constant.cardHeaderSize)
        type = LayoutController.getLabel(text: "Tennis", parentView: self.view)

        lengthRemainingTitle = LayoutController.getLabel(text: "Length remaining", parentView: self.view)
        lengthRemainingTitle.font = UIFont.boldSystemFont(ofSize: Constant.cardHeaderSize)
        lengthRemaining = LayoutController.getLabel(text: "217", parentView: self.view)

        priceTitle = LayoutController.getLabel(text: "Avg. price per racket", parentView: self.view)
        priceTitle.font = UIFont.boldSystemFont(ofSize: Constant.cardHeaderSize)
        price = LayoutController.getLabel(text: "98.02", parentView: self.view)
    }

    private func generateTopHeaderStackView() {
        let listOfViews: [UILabel] = [brandTitle, modelTitle, typeTitle]
        centerAlignUILabels(uiLabelArry: listOfViews)
        topHeaderStackView = LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func generateTopValueStackView() {
        let listOfView: [UILabel] = [brand, model, type]
        centerAlignUILabels(uiLabelArry: listOfView)
        topValueStackView = LayoutController.getStackView(content: listOfView, orientation: .horizontal, parentView: self.view)
    }

    private func generateBottomValueStackView() {
        let listOfView: [UILabel] = [lengthRemaining, price]
        centerAlignUILabels(uiLabelArry: listOfView)
        bottomValueStackView = LayoutController.getStackView(content: listOfView, orientation: .horizontal, parentView: self.view)
    }

    private func generateBottomHeaderStackView() {
        let listOfView: [UILabel] = [lengthRemainingTitle, priceTitle]
        centerAlignUILabels(uiLabelArry: listOfView)
        bottomHeaderStackView = LayoutController.getStackView(content: listOfView, orientation: .horizontal, parentView: self.view)
    }

    private func setupStringAdditionFields() {
        lengthInput = LayoutController.getTextField(placeholder: "Length", parentView: self.view)
        dateInput = LayoutController.getTextField(placeholder: "Select date", parentView: self.view)
        priceInput = LayoutController.getTextField(placeholder: "Price", parentView: self.view)

        additionButton = LayoutController.getButton(title: "Add", parentView: self.view)
        additionButton.layer.cornerRadius = Constant.smallCornerRadius
    }

    private func generateAdditionStackView() {
        let listOfView: [UIView] = [lengthInput, dateInput, priceInput, additionButton]
        additionStackView = LayoutController.getStackView(content: listOfView, orientation: .horizontal, parentView: self.view)
    }

    private func centerAlignUILabels(uiLabelArry: [UILabel]) {
        for label in uiLabelArry {
            label.textAlignment = .center
        }
    }

    private func setupConstraints() {
        Layout.addTopConstraint(on: topHeaderStackView, to: self.view.safeAreaLayoutGuide.topAnchor)
        Layout.addLeadingConstraint(on: topHeaderStackView, to: self.view.safeAreaLayoutGuide.leadingAnchor)
        Layout.addTrailingConstraint(on: topHeaderStackView, to: self.view.safeAreaLayoutGuide.trailingAnchor)

        Layout.addTopConstraint(on: topValueStackView, to: self.topHeaderStackView.bottomAnchor)
        Layout.addLeadingConstraint(on: topValueStackView, to: self.view.safeAreaLayoutGuide.leadingAnchor)
        Layout.addTrailingConstraint(on: topValueStackView, to: self.view.safeAreaLayoutGuide.trailingAnchor)

        Layout.addBottomConstraint(on: bottomHeaderStackView, to: bottomValueStackView.topAnchor)
        Layout.addLeadingConstraint(on: bottomHeaderStackView, to: self.view.safeAreaLayoutGuide.leadingAnchor)
        Layout.addTrailingConstraint(on: bottomHeaderStackView, to: self.view.safeAreaLayoutGuide.trailingAnchor)

        Layout.addBottomConstraint(on: bottomValueStackView, to: additionButton.topAnchor, by: Constant.hugeOffset)
        Layout.addLeadingConstraint(on: bottomValueStackView, to: self.view.safeAreaLayoutGuide.leadingAnchor)
        Layout.addTrailingConstraint(on: bottomValueStackView, to: self.view.safeAreaLayoutGuide.trailingAnchor)

        Layout.addBottomConstraint(on: additionStackView, to: self.view.safeAreaLayoutGuide.bottomAnchor, by: Constant.bigOffset)
        Layout.addLeadingConstraint(on: additionStackView, to: self.view.safeAreaLayoutGuide.leadingAnchor, by: Constant.bigOffset)
        Layout.addTrailingConstraint(on: additionStackView, to: self.view.safeAreaLayoutGuide.trailingAnchor, by: Constant.bigOffset)

        for constraint in additionButton.constraints {
            constraint.isActive = false
        }
    }

    @objc func cancelAction() {

    }

    @objc func deleteAction() {

    }
}
