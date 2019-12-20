//
//  SpecificOrderViewController.swift
//  StringR.Store
//
//  Created by Jaafar on 23/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import UIKit

struct CellData {
    var opened = Bool()
    var title = String()
    var sectionData = [SectionData]()
}

struct SectionData {
    var title = String()
    var value = String()
}

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
    var order: Order?
    var orderStatus: Int?
    var paidStatus: Bool?

    // testing
    weak var orderInfoTableView: UITableView!
    var tableViewData = [CellData]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // data for testing
        tableViewData = [
            CellData(opened: false, title: "Order Info", sectionData: [
                SectionData(title: "String", value: "\(self.order!.racketString!.brand.rawValue) | \(self.order!.racketString!.modelName) | \(self.order!.racketString!.color.rawValue)"),
                SectionData(title: "Price", value: "\(self.order?.price ?? 0)"),
                SectionData(title: "Delivery date", value: Utility.dateToString(date: Date(milliseconds: self.order!.deliveryDate), withTime: true) )]),
            CellData(opened: false, title: "Customer", sectionData: [
                SectionData(title: "Name", value: self.order?.customer?.name ?? "No Value"),
                SectionData(title: "PhoneNumber", value: self.order?.customer?.phoneNumber ?? "No Value"),
                SectionData(title: "Email", value: self.order?.customer?.email ?? "No Value")]),
            CellData(opened: false, title: "Stringer", sectionData: [
                SectionData(title: "Name", value: self.order?.stringer?.name ?? "No Value"),
                SectionData(title: "PhoneNumber", value: self.order?.stringer?.phoneNumber ?? "No Value"),
                SectionData(title: "Email", value: self.order?.stringer?.email ?? "No Value")]),
            CellData(opened: false, title: "Racket specifications", sectionData: [
                SectionData(title: "Brand", value: self.order?.racket?.brand.rawValue ?? "No Value"),
                SectionData(title: "Model", value: self.order?.racket?.modelName ?? "No Value"),
                SectionData(title: "String pattern", value: "M: \(self.order?.racket?.main ?? 0) | C: \(self.order?.racket?.cross ?? 0)")])]

        setupView()
        setupLabels()
        //setupGeneralStackView()
        setupSegmentedControlStackView()
        setupConstraints()
        setupOrderInfoTableView()
        updateUI()
    }

    private func setupOrderInfoTableView() {
        self.orderInfoTableView = LayoutController.getTableView(cellType: OrderInfoTitleCell.self, cellIdentifier: OrderInfoTitleCell.identifier, parentView: self.view)

        Layout.addTopConstraint(on: self.orderInfoTableView, to: self.comment.bottomAnchor)
        Layout.addBottomConstraint(on: self.orderInfoTableView, to: self.paidSegmentedControl.topAnchor)
        Layout.addLeadingConstraint(on: self.orderInfoTableView, to: self.view.safeAreaLayoutGuide.leadingAnchor)
        Layout.addTrailingConstraint(on: self.orderInfoTableView, to: self.view.safeAreaLayoutGuide.trailingAnchor)

        self.orderInfoTableView.dataSource = self
        self.orderInfoTableView.delegate = self
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
        if let order = self.order, let racketString = self.order?.racketString, let customer = self.order?.customer, let stringer = order.stringer, let racket = order.racket {
            self.orderStatus = OrderStatus.indexOfOrderStatus(orderStatus: order.orderStatus)

            if OrderStatus.indexOfOrderStatus(orderStatus: order.orderStatus) == 3 {
                self.statusSegmentedControl.isEnabled = false
                self.navigationItem.rightBarButtonItem = nil
            }

            self.paidStatus = order.paid

            if order.paid {
                self.paidSegmentedControl.isEnabled = false
            }

            self.title = "\(customer.name) | \(Utility.getLastChars(string: order.orderId, amount: 4))"
            self.brand.text = racketString.brand.rawValue
            self.model.text = racketString.modelName
            self.type.text = racketString.stringType.rawValue
            self.tension.text = "M:\(order.tensionVertical) | C:\(order.tensionHorizontal)"
            self.price.text = String(Int(order.price))
            self.deliveryDate.text = Utility.dateToString(date: Date.init(milliseconds: order.deliveryDate), withTime: false)
            self.stringer.text = stringer.name
            self.paidSegmentedControl.selectedSegmentIndex = order.paid ? 1 : 0
            self.statusSegmentedControl.selectedSegmentIndex = OrderStatus.indexOfOrderStatus(orderStatus: order.orderStatus)
            self.racketBrand.text = racket.brand.rawValue
            self.racketModel.text = racket.modelName
            self.name.text = customer.name
            self.phoneNumber.text = customer.phoneNumber
            self.mail.text = customer.email

            if let comment = order.comment {
                self.comment.text = comment.isEmpty ? Utility.getString(forKey: "specificOrder_order_comment_noComment") : comment
            } else {
                self.comment.text = Utility.getString(forKey: "specificOrder_order_comment_noComment")
            }
        }
    }

    private func setupConstraints() {
//        Layout.addTopConstraint(on: self.generalStackView, to: self.view.safeAreaLayoutGuide.topAnchor)
//        Layout.addLeadingConstraint(on: self.generalStackView, to: self.view.safeAreaLayoutGuide.leadingAnchor)
//        Layout.addTrailingConstraint(on: self.generalStackView, to: self.view.safeAreaLayoutGuide.trailingAnchor)
//
        Layout.addTopConstraint(on: self.commentHeader, to: self.view.safeAreaLayoutGuide.topAnchor, by: Constant.bigOffset)
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
            if OrderStatus.allValues[orderStatus] != order.orderStatus || paidStatus != order.paid {
                let history = OrderHistory.init(date: Date().millisecondsSince1970, paid: paidStatus, orderStatus: OrderStatus.allValues[orderStatus])
                order.orderHistory?.append(history)
            }

            order.orderStatus = OrderStatus.allValues[orderStatus]
            order.paid = paidStatus

            self.orderController.putOrder(order: order) { (success) in
                if success {
                    self.saveAndDismiss()
                } else {
                    self.presentDefaultAlert()
                }

                self.removeSpinner(forSpinner: spinner)
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
            if !(sender.selectedSegmentIndex == OrderStatus.indexOfOrderStatus(orderStatus: order.orderStatus) + 1 ||
                sender.selectedSegmentIndex == OrderStatus.indexOfOrderStatus(orderStatus: order.orderStatus)) {
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

extension SpecificOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened {
            return tableViewData[section].sectionData.count + 1
        } else {
            return 1
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderInfoTitleCell.identifier) else { return UITableViewCell() }

            cell.textLabel?.text = tableViewData[indexPath.section].title

            return cell
        } else {
            let cell = TwoSidedTextCell()

            cell.leftLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1].title
            cell.rightLabel.text = tableViewData[indexPath.section].sectionData[indexPath.row - 1].value

            cell.isUserInteractionEnabled = false

            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened {
                tableViewData[indexPath.section].opened = false

                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            } else {
                tableViewData[indexPath.section].opened = true

                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
    }
}
// swiftlint:enable type_body_length
