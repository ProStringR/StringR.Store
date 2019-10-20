//
//  SpecificStringInStorageViewController.swift
//  StringR.Store
//
//  Created by Jaafar on 18/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import UIKit

class SpecificStringInStorageViewController: UIViewController {

    let storageController = ControlReg.getStorageController

    var racketString: RacketString?

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
    weak var purhcaseHistoryTitle: UILabel!

    weak var lengthInput: UITextField!
    weak var priceInput: UITextField!
    weak var dateInput: UITextField!

    weak var topHeaderStackView: UIStackView!
    weak var topValueStackView: UIStackView!
    weak var bottomHeaderStackView: UIStackView!
    weak var bottomValueStackView: UIStackView!
    weak var additionStackView: UIStackView!

    weak var additionButton: UIButton!
    weak var historyTableView: UITableView!

    var purchaseHistoryList: [PurchaseHistory]?

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
        generatePurchaseHistoryTableView()
        getStringData()
        setupConstraints()
    }

    private func setupView() {
        self.view.backgroundColor = .white
        self.view.layer.cornerRadius = Constant.standardCornerRadius
        self.navigationController?.hideNavigationBar()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAction))
    }

    private func setupLabels() {
        brandTitle = LayoutController.getLabel(text: "Brand", parentView: self.view)
        brandTitle.font = UIFont.boldSystemFont(ofSize: Constant.headerSize)
        brand = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)

        modelTitle = LayoutController.getLabel(text: "Model", parentView: self.view)
        modelTitle.font = UIFont.boldSystemFont(ofSize: Constant.headerSize)
        model = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)

        typeTitle = LayoutController.getLabel(text: "Type", parentView: self.view)
        typeTitle.font = UIFont.boldSystemFont(ofSize: Constant.headerSize)
        type = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)

        lengthRemainingTitle = LayoutController.getLabel(text: "Length remaining", parentView: self.view)
        lengthRemainingTitle.font = UIFont.boldSystemFont(ofSize: Constant.headerSize)
        lengthRemaining = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)

        priceTitle = LayoutController.getLabel(text: "Avg. price per racket", parentView: self.view)
        priceTitle.font = UIFont.boldSystemFont(ofSize: Constant.headerSize)
        price = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)

        purhcaseHistoryTitle = LayoutController.getLabel(text: "Purchase history", parentView: self.view)
        purhcaseHistoryTitle.font = UIFont.boldSystemFont(ofSize: Constant.smallHeaderSize)
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
        additionButton.addTarget(self, action: #selector(onAddButtonClicked(_:)), for: .touchUpInside)
        additionButton.layer.cornerRadius = Constant.smallCornerRadius
    }

    private func generateAdditionStackView() {
        let listOfView: [UIView] = [lengthInput, dateInput, priceInput, additionButton]
        additionStackView = LayoutController.getStackView(content: listOfView, orientation: .horizontal, parentView: self.view)
    }

    private func generatePurchaseHistoryTableView() {
        self.historyTableView = LayoutController.getTableView(cellType: TwoSidedTextCell.self, cellIdentifier: TwoSidedTextCell.identifier, parentView: self.view)

        self.historyTableView.dataSource = self
    }

    private func centerAlignUILabels(uiLabelArry: [UILabel]) {
        for label in uiLabelArry {
            label.textAlignment = .center
        }
    }

    private func getStringData() {
        if let racketString = racketString {
            self.purchaseHistoryList = racketString.purchaseHistory
            self.historyTableView.reloadData()

            self.brand.text = racketString.brand.rawValue
            self.model.text = racketString.modelName
            self.type.text = racketString.stringType.rawValue
            self.lengthRemaining.text = String(racketString.lengthRemaining)
            self.price.text = String(racketString.racketRemaining)
        }
    }

    private func setupConstraints() {
        Layout.addTopConstraint(on: topHeaderStackView, to: self.view.safeAreaLayoutGuide.topAnchor)
        Layout.addLeadingConstraint(on: topHeaderStackView, to: self.view.safeAreaLayoutGuide.leadingAnchor)
        Layout.addTrailingConstraint(on: topHeaderStackView, to: self.view.safeAreaLayoutGuide.trailingAnchor)

        Layout.addTopConstraint(on: topValueStackView, to: self.topHeaderStackView.bottomAnchor)
        Layout.addLeadingConstraint(on: topValueStackView, to: self.view.safeAreaLayoutGuide.leadingAnchor)
        Layout.addTrailingConstraint(on: topValueStackView, to: self.view.safeAreaLayoutGuide.trailingAnchor)

        Layout.addTopConstraint(on: purhcaseHistoryTitle, to: topValueStackView.bottomAnchor, by: Constant.bigOffset)
        Layout.addLeadingConstraint(on: purhcaseHistoryTitle, to: self.view.safeAreaLayoutGuide.leadingAnchor, by: Constant.bigOffset)

        Layout.addTopConstraint(on: historyTableView, to: purhcaseHistoryTitle.bottomAnchor)
        Layout.addLeadingConstraint(on: historyTableView, to: self.view.safeAreaLayoutGuide.leadingAnchor)
        Layout.addTrailingConstraint(on: historyTableView, to: self.view.safeAreaLayoutGuide.trailingAnchor)
        Layout.addBottomConstraint(on: historyTableView, to: bottomHeaderStackView.topAnchor, by: Constant.bigOffset)

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

    @objc func onAddButtonClicked(_ sender: UIButton) {
        guard let strindId = self.racketString?.stringId, let itemNumber = self.purchaseHistoryList?.count else { return }

        let purchaseHistory = PurchaseHistory.init(date: 1234223, length: 22, price: 66)

        self.storageController.putRacketStringHistoryItem(purchaseHistoryItem: purchaseHistory, stringId: strindId, historyNumber: itemNumber) { (succes) in
            if succes {
                print("All is good")
            } else {
                print("fuck this shit")
            }
        }
    }

    @objc func cancelAction() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

    @objc func deleteAction() {

    }
}

extension SpecificStringInStorageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = self.purchaseHistoryList {
            return list.count
        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let purchaseHistory = self.purchaseHistoryList else { return UITableViewCell() }

        // swiftlint:disable force_cast
        let cell = self.historyTableView.dequeueReusableCell(withIdentifier: TwoSidedTextCell.identifier, for: indexPath) as! TwoSidedTextCell
        // swiftlint:enable force_cast

        let item = purchaseHistory[indexPath.row]

        cell.leftLabel.text = String(item.price)
        cell.rightLabel.text = String(item.length)

        return cell
    }
}
