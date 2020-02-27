//
//  CreateOrderViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 11/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

// swiftlint:disable type_body_length
class CreateOrderViewController: UIViewController {

    weak var generalStackView: UIStackView!

    weak var customerStackView: UIStackView!
    weak var customerLabel: UILabel!
    weak var pickCustomerButton: UIButton!
    weak var customerInfoStackView: UIStackView!
    weak var customerName: UILabel!
    weak var customerPhoneNumber: UILabel!

    weak var specificationStackView: UIStackView!
    weak var specificationLabel: UILabel!
    weak var racketTypeSegmentedControl: UISegmentedControl!
    weak var stringTextField: UITextField!
    weak var tensionStackView: UIStackView!
    weak var tensionVerticalTextField: UITextField!
    weak var tensionHorizontalTextField: UITextField!
    weak var stringerTextField: UITextField!
    weak var racketInfoStackView: UIStackView!
    weak var racketBrandTextField: UITextField!
    weak var racketModelTextView: UITextField!

    weak var deliveryStackView: UIStackView!
    weak var deliveryLabel: UILabel!
    weak var deliveryDateTextField: UITextField!

    weak var priceStackView: UIStackView!
    weak var priceLabel: UILabel!
    weak var priceTextField: UITextField!

    weak var commentStackView: UIStackView!
    weak var commentLabel: UILabel!
    weak var commentTextField: UITextField!

    weak var placeOrderButton: UIButton!

    var customer: CustomerFb?
    var racketType: RacketType?
    var racketString: RacketStringFb?
    var stringer: StringerFb?
    var deliveryDate: Date?
    var racketBrand: RacketBrand?

    var racketStrings: [RacketStringFb]?
    var avalibleRacketString: [RacketStringFb]?
    var stringers: [StringerFb]?
    var racketBrands = RacketBrand.allValues
    var racketStringsPickerView = UIPickerView()
    var stringersPickerView = UIPickerView()
    var datePicker = UIDatePicker()
    var racketBrandPickerView = UIPickerView()

    let orderController = ControlReg.getOrderController
    let teamController = ControlReg.getTeamController
    let storageController = ControlReg.getStorageController
    let customerController = ControlReg.getCustomerController
    let shopController = ControlReg.getShopController
    // TODO: Delete, when we have a racket on Customer.
    let racketController = ControlReg.getRacketController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupCustromerStackView()
        setupSpecificationStackView()
        setupDeliveryStackView()
        setupPriceStackView()
        setupCommentStackView()
        setupPlaceOrderButton()
        setupGeneralStackView()
        setupPickerViews()
        setupConstraints()
        // Get data
        getStringers()
        getRacketStrings()

        // set tapGesture to close keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }

    private func getStringers() {
        ShopSingleton.shared.getShop { (shop) in
            guard let shop = shop else { return }
            self.teamController.getStringers(fromTeamId: shop.teamId) { (result) in
                if let stringers = result {
                    self.stringers = stringers
                } else {
                    // TODO: Manange if something went wrong
                }
            }
        }
    }

    private func getRacketStrings() {
        ShopSingleton.shared.getShop { (shop) in
            guard let shop = shop else { return }
            self.storageController.getListOfStringsInStorage(fromShopId: shop.storageId) { (result) in
                if let racketStrings = result {
                    self.racketStrings = racketStrings
                    self.reloadPickers()
                }
            }
        }
    }

    private func setupView() {
        self.view.backgroundColor = .white
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: Utility.getString(forKey: "orderViewController_OrderCreationHead")))
    }

    private func reloadPickers() {
        DispatchQueue.main.async {
            if let racketStrings = self.racketStrings, let racketType = self.racketType {
                self.avalibleRacketString = self.storageController.filterStrings(racketStrings: racketStrings, by: racketType)
            }
            self.stringersPickerView.reloadAllComponents()
        }
    }

    private func setupGeneralStackView() {
        let content = [self.customerStackView, self.specificationStackView, self.deliveryStackView, self.priceStackView, self.commentStackView]
        self.generalStackView = LayoutController.getStackView(content: content, orientation: .vertical, parentView: self.view)
        self.generalStackView.alignment = .top
        self.generalStackView.distribution = .fillProportionally
    }

    private func setupCustromerStackView() {
        self.customerLabel = LayoutController.getSmallHeader(text: Utility.getString(forKey: "createOrderViewController_customerLabel"), parentView: self.view)
        self.pickCustomerButton = LayoutController.getButton(title: Utility.getString(forKey: "createOrderViewController_chooseCustomerButton"), parentView: self.view)
        self.pickCustomerButton.addTarget(self, action: #selector(pickCustomerButtonCliked(_:)), for: .touchUpInside)
        setupCustomerInfoStackView()

        let content = [self.customerLabel, self.pickCustomerButton, self.customerInfoStackView]
        self.customerStackView = LayoutController.getStackView(content: content, orientation: .vertical, parentView: self.view)
        self.customerStackView.alignment = .fill
    }

    private func setupSpecificationStackView() {
        self.specificationLabel = LayoutController.getSmallHeader(text: Utility.getString(forKey: "createOrderViewController_racketSpecificationLabel"), parentView: self.view)
        setupSegmentedControl()
        self.stringTextField = LayoutController.getTextField(placeholder: Utility.getString(forKey: "createOrderViewController_chooseString"), parentView: self.view)
        self.stringerTextField = LayoutController.getTextField(placeholder: Utility.getString(forKey: "createOrderViewController_chooseStringer"), parentView: self.view)
        setupTensionStackView()
        setupRacketInfoStackView()

        let content = [self.specificationLabel, self.racketTypeSegmentedControl, self.stringTextField, self.stringerTextField, self.tensionStackView, self.racketInfoStackView]
        self.specificationStackView = LayoutController.getStackView(content: content, orientation: .vertical, parentView: self.view)
        self.specificationStackView.alignment = .fill
        self.specificationStackView.spacing = 16
    }

    private func setupDeliveryStackView() {
        self.deliveryLabel = LayoutController.getSmallHeader(text: Utility.getString(forKey: "createOrderViewController_deliveryInfoLabel"), parentView: self.view)
        self.deliveryDateTextField = LayoutController.getTextField(placeholder: Utility.getString(forKey: "createOrderViewController_deliveryDate"), parentView: self.view)

        let content = [self.deliveryLabel, self.deliveryDateTextField]
        self.deliveryStackView = LayoutController.getStackView(content: content, orientation: .vertical, parentView: self.view)
        self.deliveryStackView.alignment = .fill
    }

    private func setupPriceStackView() {
        self.priceLabel = LayoutController.getSmallHeader(text: Utility.getString(forKey: "createOrderViewController_priceLabel"), parentView: self.view)
        self.priceTextField = LayoutController.getTextField(placeholder: Utility.getString(forKey: "createOrderViewController_priceLabel"), parentView: self.view)

        let content = [self.priceLabel, self.priceTextField]
        self.priceStackView = LayoutController.getStackView(content: content, orientation: .vertical, parentView: self.view)
        self.priceStackView.alignment = .fill
    }

    private func setupCommentStackView() {
        self.commentLabel = LayoutController.getSmallHeader(text: Utility.getString(forKey: "createOrderViewController_commentLabel"), parentView: self.view)
        self.commentTextField = LayoutController.getTextField(placeholder: Utility.getString(forKey: "createOrderViewController_commentDescription"), parentView: self.view)

        let content = [self.commentLabel, self.commentTextField]
        self.commentStackView = LayoutController.getStackView(content: content, orientation: .vertical, parentView: self.view)
        self.commentStackView.alignment = .fill
    }

    private func setupCustomerInfoStackView() {
        self.customerName = LayoutController.getLabel(text: nil, parentView: self.view)
        self.customerName.textAlignment = .center
        self.customerName.font = self.customerName.font.withSize(20)

        self.customerPhoneNumber = LayoutController.getLabel(text: nil, parentView: self.view)
        self.customerPhoneNumber.textAlignment = .center
        self.customerPhoneNumber.font = self.customerPhoneNumber.font.withSize(20)

        let content = [self.customerName, self.customerPhoneNumber]
        self.customerInfoStackView = LayoutController.getStackView(content: content, orientation: .vertical, parentView: self.view)
        self.customerInfoStackView.alignment = .fill
    }

    private func setupSegmentedControl() {
        let items = [Utility.getString(forKey: "generel_Badminton"), Utility.getString(forKey: "generel_Tennis"), Utility.getString(forKey: "generel_Squash")]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)

        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.selectedSegmentIndex = 0
        self.racketType = .BADMINTON
        segmentedControl.layer.cornerRadius = Constant.standardCornerRadius
        segmentedControl.backgroundColor = .black
        segmentedControl.tintColor = .white

        self.view.addSubview(segmentedControl)
        self.racketTypeSegmentedControl = segmentedControl
    }

    private func setupTensionStackView() {
        self.tensionHorizontalTextField = LayoutController.getTextField(placeholder: Utility.getString(forKey: "createOrderViewController_crossTension"), parentView: self.view)
        self.tensionHorizontalTextField.keyboardType = .decimalPad
        self.tensionVerticalTextField = LayoutController.getTextField(placeholder: Utility.getString(forKey: "createOrderViewController_mainTension"), parentView: self.view)
        self.tensionVerticalTextField.keyboardType = .decimalPad

        let content = [self.tensionVerticalTextField, self.tensionHorizontalTextField]
        self.tensionStackView = LayoutController.getStackView(content: content, orientation: .horizontal, parentView: self.view)
        self.tensionStackView.distribution = .fillEqually
    }

    private func setupRacketInfoStackView() {
        self.racketBrandTextField = LayoutController.getTextField(placeholder: Utility.getString(forKey: "specificOrder_racket_brand"), parentView: self.view)
        self.racketModelTextView = LayoutController.getTextField(placeholder: Utility.getString(forKey: "specificOrder_racket_model"), parentView: self.view)

        let content = [self.racketBrandTextField, self.racketModelTextView]
        self.racketInfoStackView = LayoutController.getStackView(content: content, orientation: .horizontal, parentView: self.view)
        self.racketInfoStackView.distribution = .fillEqually
    }

    private func setupPlaceOrderButton() {
        self.placeOrderButton = LayoutController.getButton(title: Utility.getString(forKey: "createOrderViewController_placeOrderButton"), parentView: self.view)
        self.placeOrderButton.addTarget(self, action: #selector(placeOrderClicked(_:)), for: .touchUpInside)
    }

    private func setupConstraints() {

        Layout.addTopConstraint(on: self.generalStackView, to: self.view.safeAreaLayoutGuide.topAnchor)
        Layout.addLeadingConstraint(on: self.generalStackView, to: self.view.safeAreaLayoutGuide.leadingAnchor, by: Constant.gigantOffset)
        Layout.addTrailingConstraint(on: self.generalStackView, to: self.view.safeAreaLayoutGuide.trailingAnchor, by: Constant.gigantOffset)
        Layout.addBottomConstraint(on: self.generalStackView, to: self.placeOrderButton.topAnchor, by: Constant.hugeOffset)

        Layout.addTrailingConstraint(on: self.customerStackView, to: self.generalStackView.trailingAnchor, by: Constant.noOffset)
        Layout.addTrailingConstraint(on: self.specificationStackView, to: self.generalStackView.trailingAnchor, by: Constant.noOffset)
        Layout.addTrailingConstraint(on: self.deliveryStackView, to: self.generalStackView.trailingAnchor, by: Constant.noOffset)
        Layout.addTrailingConstraint(on: self.priceStackView, to: self.generalStackView.trailingAnchor, by: Constant.noOffset)
        Layout.addTrailingConstraint(on: self.commentStackView, to: self.generalStackView.trailingAnchor, by: Constant.noOffset)

        Layout.addBottomConstraint(on: self.placeOrderButton, to: self.view.safeAreaLayoutGuide.bottomAnchor)
        Layout.addLeadingConstraint(on: self.placeOrderButton, to: self.view.safeAreaLayoutGuide.leadingAnchor, by: Constant.gigantOffset)
        Layout.addTrailingConstraint(on: self.placeOrderButton, to: self.view.safeAreaLayoutGuide.trailingAnchor, by: Constant.gigantOffset)
    }

    private func setupPickerViews() {
        self.initPicker(picker: self.stringersPickerView, inputField: self.stringerTextField)
        self.initPicker(picker: self.racketStringsPickerView, inputField: self.stringTextField)
        self.initPicker(picker: self.racketBrandPickerView, inputField: self.racketBrandTextField)

        // setup date picker
        self.datePicker.datePickerMode = .dateAndTime
        self.datePicker.minimumDate = Date()
        self.datePicker.addTarget(self, action: #selector(dataChanged(datePicker:)), for: .valueChanged)
        self.deliveryDateTextField.inputView = self.datePicker
    }

    @objc func dataChanged(datePicker: UIDatePicker) {
        self.deliveryDateTextField.text = Utility.dateToString(date: datePicker.date)
        self.deliveryDate = datePicker.date
    }

    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @objc func pickCustomerButtonCliked(_ sender: UIButton) {
        let viewControllerToPresent = FindCustomerViewController()
        viewControllerToPresent.delegate = self
        let popup = LayoutController.getPopupView(viewControllerToPresent: viewControllerToPresent)
        self.navigationController?.present(popup, animated: true, completion: nil)

        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }

    @objc func placeOrderClicked(_ sender: UIButton) {
        guard let customer = self.customer, let verticalTension = self.tensionVerticalTextField.text, let horizontalTension = self.tensionHorizontalTextField.text, let price = self.priceTextField.text, let racketBrand = self.racketBrand, let racketModel = self.racketModelTextView.text, let comment = self.commentTextField.text else { submissionFailed(); return }

        ShopSingleton.shared.getShop { (shop) in
            if let shop = shop {

                // TODO: delete, when we have racket on the Customer. Then pass the racketId on to the order.
                let tempRacket = RacketFb(racketId: Utility.getUUID(), brand: racketBrand, modelName: racketModel)

                let order = OrderFb.init(orderId: Utility.getUUID(), customerId: customer.userId, stringerId: self.stringer?.userId, shopId: shop.shopId, racketId: tempRacket.racketId, racketType: self.racketType, tensionVertical: Double(verticalTension.replacingOccurrences(of: ",", with: ".")), tensionHorizontal: Double(horizontalTension.replacingOccurrences(of: ",", with: ".")), stringId: self.racketString?.stringId, deliveryDate: self.deliveryDate?.millisecondsSince1970, price: Double(price), paid: false)

                order?.comment = comment

                self.racketController.putRacket(racket: tempRacket) { (succes) in
                    if succes {
                        self.orderController.putOrder(order: order) { (succes) in
                            if succes {
                                // set orderId to stringer
                                guard let order = order else { self.submissionFailed(); return }

                                self.stringer?.orderIds = self.appendOrderId(orderIds: self.stringer?.orderIds, orderId: order.orderId)

                                if let stringer = self.stringer {
                                    self.teamController.putStringer(stringer: stringer) { (succes) in
                                        if !succes {
                                            self.submissionFailed()
                                        }
                                    }
                                }

                                // set orderId to customer
                                self.customer?.orderIds = self.appendOrderId(orderIds: self.customer?.orderIds, orderId: order.orderId)

                                if let customer = self.customer {
                                    self.customerController.putCustomer(customer: customer) { (succes) in
                                        if !succes {
                                            self.submissionFailed()
                                        }
                                    }
                                }

                                // set orderId to shop
                                ShopSingleton.shared.getShop { (shop) in
                                    if let shop = shop {
                                        shop.orderIds = self.appendOrderId(orderIds: shop.orderIds, orderId: order.orderId)
                                        self.shopController.putShop(shop: shop) { (succes) in
                                            if !succes {
                                                self.submissionFailed()
                                            }
                                        }
                                    }
                                }

                                if let racketString = self.racketString {
                                    self.storageController.removeSpecificLengthFromRacketString(racketString: racketString, length: Double(Constant.stringLengthPerRacket), storageId: order.shopId) { (succes) in
                                        if !succes {
                                            self.submissionFailed()
                                        }
                                    }
                                }

                                // collect the racketBrand and racketModel to the racketDict table in the database
                                self.racketController.putTempRacket(racket: tempRacket) { (succes) in
                                    _ = succes
                                }

                                DispatchQueue.main.async {
                                    self.navigationController?.popViewController(animated: true)
                                }
                            } else {
                                self.submissionFailed()
                            }
                        }
                    }
                }
            }
        }
    }

    private func appendOrderId(orderIds: [String]?, orderId: String) -> [String] {
        if var orderIds = orderIds {
            orderIds.append(orderId)
            return orderIds
        } else {
            return [orderId]
        }
    }

    private func submissionFailed() {
        let alert = LayoutController.getAlert(withTitle: Utility.getString(forKey: "common_Ups"), withMessage: Utility.getString(forKey: "createOrderViewController_creationFail"))
        alert.addAction(UIAlertAction(title: Utility.getString(forKey: "common_cancel"), style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: Utility.getString(forKey: "common_tryAgain"), style: .default, handler: { (alert) in
            _ = alert
            self.placeOrderClicked(self.placeOrderButton)
        }))

        self.present(alert, animated: true)
    }

    private func setCustomer(customer: CustomerFb) {
        self.customer = customer

        if let customer = self.customer {
            DispatchQueue.main.async {
                self.customerName.text = customer.name
                self.customerPhoneNumber.text = customer.phoneNumber
            }
        }
    }

    private func initPicker(picker: UIPickerView, inputField: UITextField!) {
        picker.delegate = self
        picker.dataSource = self
        inputField.inputView = picker
    }

    @objc func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.racketType = .BADMINTON
        case 1:
            self.racketType = .TENNIS
        case 2:
            self.racketType = .SQUASH
        default:
            print("Default")
        }

        self.reloadPickers()
    }
}

extension CreateOrderViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case self.stringersPickerView:
            if let stringers = self.stringers {
                return stringers.count
            }
        case self.racketStringsPickerView:
            if let racketStrings = self.avalibleRacketString {
                return racketStrings.count
            }
        case self.racketBrandPickerView:
            return self.racketBrands.count
        default:
            return 0
        }

        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case self.stringersPickerView:
            if let stringers = self.stringers {
                return stringers[row].name
            }
        case self.racketStringsPickerView:
            if let racketStrings = self.avalibleRacketString {
                return racketStrings[row].getDescription()
            }
        case self.racketBrandPickerView:
            return self.racketBrands[row].rawValue
        default:
            return nil
        }

        return nil
    }
}

extension CreateOrderViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.stringersPickerView {
            if let stringers = self.stringers {
                self.stringer = stringers[row]
                self.stringerTextField.text = stringers[row].name
            }
        } else if pickerView == self.racketStringsPickerView {
            if let racketStrings = self.avalibleRacketString {
                self.racketString = racketStrings[row]
                self.stringTextField.text = racketStrings[row].getDescription()
                self.priceTextField.text = String(racketStrings[row].pricePerRacket)
            }
        } else if pickerView == self.racketBrandPickerView {
            self.racketBrand = self.racketBrands[row]
            self.racketBrandTextField.text = self.racketBrands[row].rawValue
        }
    }
}

extension CreateOrderViewController: FindCustomerDelegate {
    func addCustomer(customer: CustomerFb) {
        self.setCustomer(customer: customer)
    }

    func closeAction() {
        // show tabbar
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
}
// swiftlint:enable type_body_length
