//
//  CreateOrderViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 11/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

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

    var customer: Customer?
    var racketType: RacketType?
    var racketString: RacketString?
    var stringer: Stringer?
    var deliveryDate: Date?

    var racketStrings: [RacketString]?
    var avalibleRacketString: [RacketString]?
    var stringers: [Stringer]?
    var racketStringsPickerView = UIPickerView()
    var stringersPickerView = UIPickerView()
    var datePicker = UIDatePicker()

    let orderController = ControlReg.getOrderController
    let teamController = ControlReg.getTeamController
    let storageController = ControlReg.getStorageController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCustromerStackView()
        setupSpecificationStackView()
        setupDeliveryStackView()
        setupPriceStackView()
        setupCommentStackView()
        setupGeneralStackView()
        setupPlaceOrderButton()
        setupPickerViews()
        // Get data
        getStringers()
        getRacketStrings()

        // set tapGesture to close keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }

    private func getStringers() {
        teamController.getStringers(fromTeamId: "teamMJ") { (result) in
            if let stringers = result {
                self.stringers = stringers
            } else {
                print("Noget gik galt")
            }
        }
    }

    private func getRacketStrings() {
        storageController.getRacketStrings(by: "ShopMJ") { (result) in
            if let racketStrings = result {
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
            }
            self.stringersPickerView.reloadAllComponents()
        }
    }

    private func setupGeneralStackView() {
        let content = [self.customerStackView, self.specificationStackView, self.deliveryStackView, self.priceStackView, self.commentStackView]
        self.generalStackView = LayoutController.getStackView(content: content, orientation: .vertical, parentView: self.view)
        self.generalStackView.alignment = .top
        self.generalStackView.distribution = .fill
        self.generalStackView.spacing = 16

        Layout.addTopConstraint(on: self.generalStackView, to: self.view.safeAreaLayoutGuide.topAnchor)
        Layout.addLeadingConstraint(on: self.generalStackView, to: self.view.safeAreaLayoutGuide.leadingAnchor, by: 64)
        Layout.addTrailingConstraint(on: self.generalStackView, to: self.view.safeAreaLayoutGuide.trailingAnchor, by: 64)

        Layout.addTrailingConstraint(on: self.customerStackView, to: self.generalStackView.trailingAnchor, by: 0)
        Layout.addTrailingConstraint(on: self.specificationStackView, to: self.generalStackView.trailingAnchor, by: 0)
        Layout.addTrailingConstraint(on: self.deliveryStackView, to: self.generalStackView.trailingAnchor, by: 0)
        Layout.addTrailingConstraint(on: self.priceStackView, to: self.generalStackView.trailingAnchor, by: 0)
        Layout.addTrailingConstraint(on: self.commentStackView, to: self.generalStackView.trailingAnchor, by: 0)
    }

    private func setupCustromerStackView() {
        self.customerLabel = LayoutController.getSmallHeader(text: "Customer", parentView: self.view)
        self.pickCustomerButton = LayoutController.getButton(title: "Choose Customer", parentView: self.view)
        self.pickCustomerButton.addTarget(self, action: #selector(pickCustomerButtonCliked(_:)), for: .touchUpInside)
        setupCustomerInfoStackView()

        let content = [self.customerLabel, self.pickCustomerButton, self.customerInfoStackView]
        self.customerStackView = LayoutController.getStackView(content: content, orientation: .vertical, parentView: self.view)
        self.customerStackView.alignment = .fill
    }

    private func setupSpecificationStackView() {
        self.specificationLabel = LayoutController.getSmallHeader(text: "Racket Specifications", parentView: self.view)
        setupSegmentedControl()
        self.stringTextField = LayoutController.getTextField(placeholder: "Choose String", parentView: self.view)
        self.stringerTextField = LayoutController.getTextField(placeholder: "Choose Stringer", parentView: self.view)
        setupTensionStackView()

        let content = [self.specificationLabel, self.racketTypeSegmentedControl, self.stringTextField, self.stringerTextField, self.tensionStackView]
        self.specificationStackView = LayoutController.getStackView(content: content, orientation: .vertical, parentView: self.view)
        self.specificationStackView.alignment = .fill
        self.specificationStackView.spacing = 16
    }

    private func setupDeliveryStackView() {
        self.deliveryLabel = LayoutController.getSmallHeader(text: "Delivery Information", parentView: self.view)
        self.deliveryDateTextField = LayoutController.getTextField(placeholder: "Choose wanted delivery time", parentView: self.view)

        let content = [self.deliveryLabel, self.deliveryDateTextField]
        self.deliveryStackView = LayoutController.getStackView(content: content, orientation: .vertical, parentView: self.view)
        self.deliveryStackView.alignment = .fill
    }

    private func setupPriceStackView() {
        self.priceLabel = LayoutController.getSmallHeader(text: "Price", parentView: self.view)
        self.priceTextField = LayoutController.getTextField(placeholder: "Price", parentView: self.view)

        let content = [self.priceLabel, self.priceTextField]
        self.priceStackView = LayoutController.getStackView(content: content, orientation: .vertical, parentView: self.view)
        self.priceStackView.alignment = .fill
    }

    private func setupCommentStackView() {
        self.commentLabel = LayoutController.getSmallHeader(text: "Comment", parentView: self.view)
        self.commentTextField = LayoutController.getTextField(placeholder: "Comment, if you have some extra information about your order", parentView: self.view)

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
        let items = ["Badminton", "Tennis", "Squash"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)

        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.selectedSegmentIndex = 0
        self.racketType = .BADMINTON
        segmentedControl.layer.cornerRadius = 5.0
        segmentedControl.backgroundColor = .black
        segmentedControl.tintColor = .white

        self.view.addSubview(segmentedControl)
        self.racketTypeSegmentedControl = segmentedControl
    }

    private func setupTensionStackView() {
        self.tensionHorizontalTextField = LayoutController.getTextField(placeholder: "Main Tension", parentView: self.view)
        self.tensionHorizontalTextField.keyboardType = .decimalPad
        self.tensionVerticalTextField = LayoutController.getTextField(placeholder: "Cross Tension", parentView: self.view)
        self.tensionVerticalTextField.keyboardType = .decimalPad

        let content = [self.tensionHorizontalTextField, self.tensionVerticalTextField]
        self.tensionStackView = LayoutController.getStackView(content: content, orientation: .horizontal, parentView: self.view)
        self.tensionStackView.distribution = .fillEqually
    }

    private func setupPlaceOrderButton() {
        self.placeOrderButton = LayoutController.getButton(title: "Place Order", parentView: self.view)
        self.placeOrderButton.addTarget(self, action: #selector(placeOrderClicked(_:)), for: .touchUpInside)

        Layout.addBottomConstraint(on: self.placeOrderButton, to: self.view.safeAreaLayoutGuide.bottomAnchor)
        Layout.addLeadingConstraint(on: self.placeOrderButton, to: self.generalStackView.leadingAnchor, by: 0)
        Layout.addTrailingConstraint(on: self.placeOrderButton, to: self.generalStackView.trailingAnchor, by: 0)

    }

    private func setupPickerViews() {
        self.initPicker(picker: self.stringersPickerView, inputField: self.stringerTextField)
        self.initPicker(picker: self.racketStringsPickerView, inputField: self.stringTextField)

        // setup date picker
        self.datePicker.datePickerMode = .dateAndTime
        self.datePicker.minimumDate = Date()
        self.datePicker.addTarget(self, action: #selector(dataChanged(datePicker:)), for: .valueChanged)
        self.deliveryDateTextField.inputView = self.datePicker
    }

    @objc func dataChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        self.deliveryDateTextField.text = dateFormatter.string(from: datePicker.date)
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
    }

    @objc func placeOrderClicked(_ sender: UIButton) {
        print("Hello there from Place Order")

        guard let verticalTension = self.tensionVerticalTextField.text, let horizontalTension = self.tensionHorizontalTextField.text, let price = self.priceTextField.text else { submissionFailed(); return }

        let order = Order.init(orderId: Utility.getUUID(), customerId: self.customer?.userId, stringerId: self.stringer?.userId, racketType: self.racketType, tensionVertical: Double(verticalTension), tensionHorizontal: Double(horizontalTension), stringId: self.racketString?.stringId, deliveryDate: self.deliveryDate?.millisecondsSince1970, price: Double(price), paid: false)

        orderController.putOrder(order: order) { (succes) in
            if succes {
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                self.submissionFailed()
            }
        }
    }

    private func submissionFailed() {
        let alert = LayoutController.getAlert(withTitle: "Ups... something went wrong", withMessage: "Something in the order creation went wrong.")
        alert.addAction(UIAlertAction(title: Utility.getString(forKey: "common_cancel"), style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: Utility.getString(forKey: "common_tryAgain"), style: .default, handler: { (alert) in
            _ = alert
            self.placeOrderClicked(self.placeOrderButton)
        }))

        self.present(alert, animated: true)
    }

    private func setCustomer(customer: Customer) {
        self.customer = customer

        if let customer = self.customer {
            self.customerName.text = customer.name
            self.customerPhoneNumber.text = customer.phoneNumber
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
        }
    }
}

extension CreateOrderViewController: FindCustomerDelegate {
    func addCustomer(customer: Customer) {
        self.setCustomer(customer: customer)

    }
}
