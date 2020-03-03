//
//  SpecificOrderViewController.swift
//  StringR.Store
//
//  Created by Jaafar on 23/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import UIKit

// swiftlint:disable type_body_length
class SpecificOrderViewController: UIViewController {

    weak var delegate: OrderModifierDelegate?

    weak var generalStackView: UIStackView!
    weak var segmentControlStackView: UIStackView!

    weak var statusSegmentedControl: UISegmentedControl!
    weak var paidSegmentedControl: UISegmentedControl!

    weak var commentHeader: UILabel!
    weak var comment: UILabel!
    weak var brand: UILabel!
    weak var model: UILabel!
    weak var type: UILabel!
    weak var tension: UILabel!
    weak var price: UILabel!
    weak var deliveryDate: UILabel!
    weak var racketBrand: UILabel!
    weak var racketModel: UILabel!
    weak var stringer: UILabel!
    weak var name: UILabel!
    weak var phoneNumber: UILabel!
    weak var mail: UILabel!

    let orderController = ControlReg.getOrderController
    var order: OrderREST?
    var orderStatus: Int?
    var paidStatus: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLabels()
        setupGeneralStackView()
        setupSegmentedControlStackView()
        setupConstraints()
        updateUI()
    }

    private func setupView() {
        self.view.backgroundColor = .white
        self.view.layer.cornerRadius = Constant.standardCornerRadius
        self.navigationController?.hideNavigationBar()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissPopup))
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        let historyButton = UIBarButtonItem(title: Utility.getString(forKey: "common_history"), style: .plain, target: self, action: #selector(onHistoryBarButtonPressed))
        self.navigationItem.rightBarButtonItems = [saveButton, historyButton]
    }

    private func setupLabels() {
        commentHeader = LayoutController.getLabel(text: Utility.getString(forKey: "specificOrder_order_commentHeader"), parentView: self.view)
        commentHeader.font = UIFont.boldSystemFont(ofSize: Constant.smallHeaderSize)
        comment = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)
        comment.numberOfLines = 0

        brand = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)
        model = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)
        type = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)
        tension = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)
        price = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)
        deliveryDate = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)
        racketBrand = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)
        racketModel = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)
        stringer = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)
        name = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)
        phoneNumber = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)
        mail = LayoutController.getLabel(text: Constant.emptyString, parentView: self.view)
    }

    private func setupGeneralStackView() {
        var listOfStackviews: [UIStackView] = []
        listOfStackviews.append(setupTopHeaderStackView())
        listOfStackviews.append(setupTopValueStackView())
        listOfStackviews.append(setupMiddleHeaderStackView())
        listOfStackviews.append(setupMiddleValueStackView())
        listOfStackviews.append(setupBottomHeaderStackView())
        listOfStackviews.append(setupBottomValueStackView())
        listOfStackviews.append(setupContactInfoHeaderStackView())
        listOfStackviews.append(setupContantInfoValueStackView())

        self.generalStackView = LayoutController.getStackView(content: listOfStackviews, orientation: .vertical, parentView: self.view)
        self.generalStackView.alignment = .fill
    }

    private func setupSegmentedControlStackView() {
        var listOfViews: [UISegmentedControl] = []

        self.statusSegmentedControl = setupStatusSegmentedControl()
        self.statusSegmentedControl.addTarget(self, action: #selector(statusIndexChanged(_:)), for: .valueChanged)

        self.paidSegmentedControl = setupPaidSegmentedControl()
        self.paidSegmentedControl.addTarget(self, action: #selector(priceIndexChanged(_:)), for: .valueChanged)

        listOfViews.append(self.paidSegmentedControl)
        listOfViews.append(self.statusSegmentedControl)

        self.segmentControlStackView = LayoutController.getStackView(content: listOfViews, orientation: .vertical, parentView: self.view)
        self.segmentControlStackView.alignment = .fill
    }

    private func setupTopHeaderStackView() -> UIStackView {
        let brandTitle = LayoutController.getLabel(text: Utility.getString(forKey: "addString_BrandLabel"), parentView: self.view)
        let modelTitle = LayoutController.getLabel(text: Utility.getString(forKey: "addString_ModelLabel"), parentView: self.view)
        let typeTitle = LayoutController.getLabel(text: Utility.getString(forKey: "addString_StringTypeLabel"), parentView: self.view)
        let listOfViews: [UILabel] = [brandTitle, modelTitle, typeTitle]
        centerAlignUILabels(uiLabelArry: listOfViews)
        setLabelAsHeader(labels: listOfViews)

        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func setupMiddleHeaderStackView() -> UIStackView {
        let tensionHeader = LayoutController.getLabel(text: Utility.getString(forKey: "common_tension"), parentView: self.view)
        let priceHeader = LayoutController.getLabel(text: Utility.getString(forKey: "common_price"), parentView: self.view)
        let deliveryDateHeader = LayoutController.getLabel(text: Utility.getString(forKey: "common_deliveryDate"), parentView: self.view)
        let listOfViews: [UILabel] = [tensionHeader, priceHeader, deliveryDateHeader]
        centerAlignUILabels(uiLabelArry: listOfViews)
        setLabelAsHeader(labels: listOfViews)

        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func setupBottomHeaderStackView() -> UIStackView {
        let racketBrand = LayoutController.getLabel(text: Utility.getString(forKey: "specificOrder_racket_brand"), parentView: self.view)
        let racketModel = LayoutController.getLabel(text: Utility.getString(forKey: "specificOrder_racket_model"), parentView: self.view)
        let stringerHeader = LayoutController.getLabel(text: Utility.getString(forKey: "specificOrder_stringer"), parentView: self.view)
        let listOfViews: [UILabel] = [racketBrand, racketModel, stringerHeader]
        centerAlignUILabels(uiLabelArry: listOfViews)
        setLabelAsHeader(labels: listOfViews)

        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func setupTopValueStackView() -> UIStackView {
        let listOfViews: [UILabel] = [brand, model, type]
        centerAlignUILabels(uiLabelArry: listOfViews)

        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func setupMiddleValueStackView() -> UIStackView {
        let listOfViews: [UILabel] = [tension, price, deliveryDate]
        centerAlignUILabels(uiLabelArry: listOfViews)

        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func setupBottomValueStackView() -> UIStackView {
        let listOfViews: [UILabel] = [racketBrand, racketModel, stringer]
        centerAlignUILabels(uiLabelArry: listOfViews)

        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func setupContactInfoHeaderStackView() -> UIStackView {
        let name = LayoutController.getLabel(text: Utility.getString(forKey: "specificOrder_customerName"), parentView: self.view)
        let phone = LayoutController.getLabel(text: Utility.getString(forKey: "specificOrder_customerPhone"), parentView: self.view)
        let mail = LayoutController.getLabel(text: Utility.getString(forKey: "specificOrder_customerMail"), parentView: self.view)
        let listOfViews: [UILabel] = [name, phone, mail]
        Layout.centerAlignUILabels(uiLabelArry: listOfViews)
        Layout.setLabelAsHeader(labels: listOfViews)

        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func setupContantInfoValueStackView() -> UIStackView {
        let listOfViews: [UILabel] = [name, phoneNumber, mail]
        Layout.centerAlignUILabels(uiLabelArry: listOfViews)

        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func setupStatusSegmentedControl() -> UISegmentedControl {
        let strings = [Utility.getString(forKey: "orderViewController_ReceivedOrdersHead"),
                       Utility.getString(forKey: "orderViewController_DoneOrdersHead"),
                       Utility.getString(forKey: "orderViewController_DeliveredOrdersHead"),
                       Utility.getString(forKey: "orderViewController_CompletedOrdersHead")]

        return LayoutController.getSegmentedControl(withItems: strings, forParent: self.view)
    }

    private func setupPaidSegmentedControl() -> UISegmentedControl {
        let strings = [ Utility.getString(forKey: "common_notPaid"), Utility.getString(forKey: "common_paid")]
        return LayoutController.getSegmentedControl(withItems: strings, forParent: self.view)
    }

    private func updateUI() {
        if let order = self.order {
            self.orderStatus = order.orderStatus

            if order.orderStatus == 3 {
                self.statusSegmentedControl.isEnabled = false
                self.navigationItem.rightBarButtonItem = nil
            }

            self.paidStatus = order.paid

            if order.paid {
                self.paidSegmentedControl.isEnabled = false
            }

            self.title = "\(order.customer.firstName)"
            self.brand.text = order.racketString.brand
            self.model.text = order.racketString.model
            self.type.text = order.racketString.type
            self.tension.text = "M:\(order.tensionVertical) | C:\(order.tensionHorizontal)"
            self.price.text = String(Int(order.price))
            self.deliveryDate.text = Utility.dateToString(date: Date.init(milliseconds: order.deliveryDate), withTime: false)
            self.stringer.text = order.stringer.firstName
            self.paidSegmentedControl.selectedSegmentIndex = order.paid ? 1 : 0
            self.statusSegmentedControl.selectedSegmentIndex = order.orderStatus
            self.racketBrand.text = order.racket.racketBrand
            self.racketModel.text = order.racket.racketModel
            self.name.text = order.customer.firstName
            self.phoneNumber.text = order.customer.phoneNumber
            self.mail.text = order.customer.email

            if let comment = order.comment {
                self.comment.text = comment.isEmpty ? Utility.getString(forKey: "specificOrder_order_comment_noComment") : comment
            } else {
                self.comment.text = Utility.getString(forKey: "specificOrder_order_comment_noComment")
            }

        }
    }

    private func setupConstraints() {
        Layout.addTopConstraint(on: self.generalStackView, to: self.view.safeAreaLayoutGuide.topAnchor)
        Layout.addLeadingConstraint(on: self.generalStackView, to: self.view.safeAreaLayoutGuide.leadingAnchor)
        Layout.addTrailingConstraint(on: self.generalStackView, to: self.view.safeAreaLayoutGuide.trailingAnchor)

        Layout.addTopConstraint(on: self.commentHeader, to: self.generalStackView.bottomAnchor, by: Constant.bigOffset)
        Layout.addLeadingConstraint(on: self.commentHeader, to: self.view.safeAreaLayoutGuide.leadingAnchor, by: Constant.bigOffset)

        Layout.addTopConstraint(on: self.comment, to: self.commentHeader.bottomAnchor)
        Layout.addLeadingConstraint(on: self.comment, to: self.view.safeAreaLayoutGuide.leadingAnchor, by: Constant.bigOffset)
        Layout.addTrailingConstraint(on: self.comment, to: self.view.safeAreaLayoutGuide.trailingAnchor, by: Constant.bigOffset)
        // TODO: there are no constraints for the bottom, which is not good
//        Layout.addBottomConstraint(on: self.comment, to: self.segmentControlStackView.topAnchor)

        Layout.addBottomConstraint(on: self.segmentControlStackView, to: self.view.safeAreaLayoutGuide.bottomAnchor)
        Layout.addLeadingConstraint(on: self.segmentControlStackView, to: self.view.safeAreaLayoutGuide.leadingAnchor)
        Layout.addTrailingConstraint(on: self.segmentControlStackView, to: self.view.safeAreaLayoutGuide.trailingAnchor)

        self.statusSegmentedControl.heightAnchor.constraint(equalToConstant: Constant.standardButtonHeight).isActive = true
        self.paidSegmentedControl.heightAnchor.constraint(equalToConstant: Constant.standardButtonHeight).isActive = true
    }

    private func centerAlignUILabels(uiLabelArry: [UILabel]) {
        for label in uiLabelArry {
            label.textAlignment = .center
        }
    }

    private func setLabelAsHeader(labels: [UILabel]) {
        for label in labels {
            label.font = UIFont.boldSystemFont(ofSize: Constant.headerSize)
        }
    }

    private func presentDefaultAlert() {
        DispatchQueue.main.async {
            let alert = LayoutController.getAlert(withTitle: Utility.getString(forKey: "common_Ups"), withMessage: Utility.getString(forKey: "specificOrder_one_step_error"))
            alert.addAction(UIAlertAction(title: Utility.getString(forKey: "common_ok"), style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }

    private func saveAndDismiss() {
        DispatchQueue.main.async {
            self.navigationController?.dismiss(animated: true, completion: {
                self.delegate?.orderHasBeenModified(update: true)
            })
        }
    }

    @objc func dismissPopup() {
        DispatchQueue.main.async {
            self.navigationController?.dismiss(animated: true, completion: {
                self.delegate?.orderHasBeenModified(update: false)
            })
        }
    }

    @objc func saveAction() {
        let spinner = LayoutController.getSpinner(forParent: self.view)
        self.showSpinner(withSpinner: spinner)

        if let order = self.order, let orderStatus = self.orderStatus, let paidStatus = self.paidStatus {
            if orderStatus != order.orderStatus || paidStatus != order.paid {
                let history = OrderHistoryREST.init(orderId: order.id, transactionDate: Date().millisecondsSince1970, paid: paidStatus, orderStatus: orderStatus)
                order.orderHistory.append(history)

                order.orderStatus = orderStatus
                order.paid = paidStatus

                self.orderController.putOrderHistoryItem(for: history) { (success) in
                    if success {
                        self.saveAndDismiss()
                    } else {
                        self.presentDefaultAlert()
                    }

                    self.removeSpinner(forSpinner: spinner)
                }
            }
        }
    }

    @objc func onHistoryBarButtonPressed() {
        let historyViewController = SpecificOrderHistoryViewController()
        historyViewController.orderHistory = self.order?.orderHistory
        self.navigationController?.pushViewController(historyViewController, animated: true)
    }

    @objc func statusIndexChanged(_ sender: UISegmentedControl) {
        if let orderStatus = self.orderStatus, let order = self.order {
            if !(sender.selectedSegmentIndex == order.orderStatus + 1 || sender.selectedSegmentIndex == order.orderStatus) {
                self.statusSegmentedControl.selectedSegmentIndex = orderStatus
                self.presentDefaultAlert()
            } else {
                self.orderStatus = sender.selectedSegmentIndex
            }
        }
    }

    @objc func priceIndexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.paidStatus = false
        case 1:
            self.paidStatus = true
        default:
            print("Something went wrong during update of paid/unpaid status")
        }
    }
}
// swiftlint:enable type_body_length
