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

    let orderController = ControlReg.getOrderController
    let teamController = ControlReg.getTeamController
    let storageController = ControlReg.getStorageController
    let customerController = ControlReg.getCustomerController

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

//        let customer = Customer(userId: Utility.getUUID(), name: "Marcus Christiansen", birthday: 123456, email: "net@mail.com", phoneNumber: "23557612", orderIds: [], preferedStringType: .POLYESTER, preferedTensionVertical: 25, prederedTensionHorizontal: 25)
//
//        self.customerController.putCustomer(customer: customer) { (succes) in
//            if succes {
//                print("Alt gik godt")
//            } else {
//                print("Alt gik dårligt!!!")
//            }
//        }
    }

    private func setupView() {
        self.view.backgroundColor = .white
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: Utility.getString(forKey: "orderViewController_OrderCreationHead")))
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
        self.customerName = LayoutController.getLabel(text: "Marcus Christiansen", parentView: self.view)
        self.customerName.textAlignment = .center
        self.customerName.font = self.customerName.font.withSize(20)

        self.customerPhoneNumber = LayoutController.getLabel(text: "25722345", parentView: self.view)
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

    @objc func pickCustomerButtonCliked(_ sender: UIButton) {
        let viewControllerToPresent = FindCustomerViewController()
        let popup = LayoutController.getPopupView(viewControllerToPresent: viewControllerToPresent)
        self.navigationController?.present(popup, animated: true, completion: nil)
    }

    @objc func placeOrderClicked(_ sender: UIButton) {
        print("Hello there from Place Order")

        guard let verticalTension = self.tensionVerticalTextField.text, let horizontalTension = self.tensionHorizontalTextField.text, let price = self.priceTextField.text else { return }

        let order = Order.init(orderId: Utility.getUUID(), customerId: self.customer?.userId, stringerId: self.stringer?.userId, racketType: self.racketType, tensionVertical: Double(verticalTension), tensionHorizontal: Double(horizontalTension), stringId: self.racketString?.stringId, deliveryDate: self.deliveryDate?.millisecondsSince1970, price: Double(price), paid: false)

        orderController.putOrder(order: order) { (succes) in
            if succes {
                self.navigationController?.popViewController(animated: true)
            } else {
                let alert = LayoutController.getAlert(withTitle: "Ups... something went wrong", withMessage: "Something in the order creation went wrong.")
                alert.addAction(UIAlertAction(title: Utility.getString(forKey: "common_cancel"), style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: Utility.getString(forKey: "common_tryAgain"), style: .default, handler: { (alert) in
                    _ = alert
                    self.placeOrderClicked(self.placeOrderButton)
                }))
            }
        }
    }

    @objc func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Badminton")
        case 1:
            print("Tennis")
        case 2:
            print("Squash")
        default:
            print("Default")
        }
    }
}
