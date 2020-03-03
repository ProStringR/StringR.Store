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

    var racketType: RacketType?
    var racketString: RacketStringREST?
    var stringer: StringerREST?
    var deliveryDate: Date?
    var racketBrand: RacketBrandREST?

    var racketStrings: [RacketStringREST]?
    var avalibleRacketString: [RacketStringREST]?
    var stringers: [StringerREST]?
    var racketBrands: [RacketBrandREST]?
    var racketStringsPickerView = UIPickerView()
    var stringersPickerView = UIPickerView()
    var datePicker = UIDatePicker()
    var racketBrandPickerView = UIPickerView()

    var chosenRacketString: RacketStringREST?
    var chosenRacketBrand: RacketBrandREST?
    var chosenStringer: StringerREST?
    var chosenCustomer: CustomerREST?

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
        initializeRacketBrandPickerViewData()

        // set tapGesture to close keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }

    private func getStringers() {

        teamController.getStringersForShop(teamId: ShopSingleton.shared.shopId) { (stringers) in
            if let stringers = stringers {
                self.stringers = stringers
            }
        }
    }

    private func getRacketStrings() {
        self.storageController.getStringsForShop(by: ShopSingleton.shared.shopId) { (racketStrings) in
            if let racketStrings = racketStrings {
                self.racketStrings = racketStrings
                self.reloadPickers()
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

                // The picker should be disabled if there is no string
                if let availableRacketString = self.avalibleRacketString {
                    if availableRacketString.count > 1 {
                        self.stringTextField.isEnabled = false
                    }
                }
            }
            self.stringersPickerView.reloadAllComponents()
            self.stringTextField.text = Constant.emptyString
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

    private func initializeRacketBrandPickerViewData() {
        RacketBrandSingleton.shared.getAllRacketBrands { (racketBrands) in
            if let racketBrands = racketBrands {
                self.racketBrands = racketBrands
            }
        }
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
        guard
            let customer = self.chosenCustomer,
            let stringer = self.chosenStringer,
            let racketBrand = self.racketBrand,
            let chosenString = self.chosenRacketString,
            let verticalTension = self.tensionVerticalTextField.text,
            let horizontalTension = self.tensionHorizontalTextField.text,
            let price = self.priceTextField.text,
            let racketModel = self.racketModelTextView.text,
            let comment = self.commentTextField.text
            else { submissionFailed(); return }

        if  let shopId = Int(ShopSingleton.shared.shopId),
            let racketBrandId = racketBrand.id,
            let stringId = chosenString.stringId,
            let deliveryDate = self.deliveryDate?.millisecondsSince1970,
            let price = Double(price) {

            let order = OrderDto.init(
                customerId: customer.customerId,
                stringerId: stringer.stringerId,
                shopId: shopId,
                racketModel: racketModel,
                racketBrand: racketBrandId,
                tensionVertical: verticalTension,
                tensionHorizontal: horizontalTension,
                stringId: stringId,
                deliveryDate: deliveryDate,
                price: price,
                comment: comment,
                datePlaced: Date().millisecondsSince1970)

            orderController.postOrder(order: order) { (success) in
                if success {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    self.submissionFailed()
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

    private func setCustomer(customer: CustomerREST) {
        self.chosenCustomer = customer

        if let customer = self.chosenCustomer {
            DispatchQueue.main.async {
                self.customerName.text = customer.firstName
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
            if let racketBrands = self.racketBrands {
                return racketBrands.count
            }
            return 0
        default:
            return 0
        }

        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case self.stringersPickerView:
            if let stringers = self.stringers {
                return stringers[row].firstName
            }
        case self.racketStringsPickerView:
            if let racketStrings = self.avalibleRacketString {
                return racketStrings[row].getDescription()
            }
        case self.racketBrandPickerView:
            if let racketBrands = self.racketBrands {
                return racketBrands[row].racketBrand
            }
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
                self.stringerTextField.text = stringers[row].firstName
                self.chosenStringer = stringers[row]
            }
        } else if pickerView == self.racketStringsPickerView {
            if let racketStrings = self.avalibleRacketString {
                self.racketString = racketStrings[row]
                self.stringTextField.text = racketStrings[row].getDescription()

                if let price = racketStrings[row].price {
                    self.priceTextField.text = String(price)
                }

                self.chosenRacketString = racketStrings[row]
            }
        } else if pickerView == self.racketBrandPickerView {
            if let racketBrands = self.racketBrands {
                self.racketBrand = racketBrands[row]
                self.racketBrandTextField.text = racketBrands[row].racketBrand
                self.chosenRacketBrand = racketBrands[row]
            }
        }
    }
}

extension CreateOrderViewController: FindCustomerDelegate {
    func addCustomer(customer: CustomerREST) {
        self.setCustomer(customer: customer)
    }

    func closeAction() {
        // show tabbar
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
}
// swiftlint:enable type_body_length
