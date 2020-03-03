//
//  AddStringerToTeamViewController.swift
//  StringR.Store
//
//  Created by Jaafar on 01/11/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import UIKit

class AddStringerToTeamViewController: UIViewController {

    weak var delegate: AddStringerToTeamDelegate?

    weak var mainStackView: UIStackView!

    weak var firstNameInput: UITextField!
    weak var lastNameInput: UITextField!
    weak var emailInput: UITextField!
    weak var phoneNumerInput: UITextField!
    weak var preferredRacketTypeInput: UITextField!

    var preferredRacketTypePicker = UIPickerView()
    var racketTypes: [PurposeREST]?
    var teamController = ControlReg.getTeamController
    var chosenPurpose: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        initializePickerViewData()
        setupMainStackView()
        setupPickerView()
        setupConstraints()

        // set tapGesture to close keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }

    private func setupView() {
        self.view.backgroundColor = .white
        self.view.layer.cornerRadius = Constant.standardCornerRadius
        self.navigationController?.hideNavigationBar()
        Layout.setupViewNavigationController(forView: self, withTitle: Utility.getString(forKey: "addStringer_title"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveStringer))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeAction))
    }

    private func initializePickerViewData() {
        PurposeSingleton.shared.getAllPurposes { (racketTypes) in
            if let racketTypes = racketTypes {
                self.racketTypes = racketTypes
            }
        }
    }

    private func setupMainStackView() {
        let listOfStackViews: [UIStackView] = [
            setupFirstNameStackView(),
            setupLastNameStackView(),
            setupEmailStackView(),
            setupPhoneNumberStackView(),
            setupPreferredRacketStackView()]

        self.mainStackView = LayoutController.getStackView(content: listOfStackViews, orientation: .vertical, parentView: self.view)
        self.mainStackView.alignment = .fill
    }

    private func setupFirstNameStackView() -> UIStackView {
        var listOfViews: [UIView] = []
        let title = LayoutController.getLabel(text: Utility.getString(forKey: "addStringer_firstName"), parentView: self.view)
        self.firstNameInput = LayoutController.getTextField(placeholder: "John", parentView: self.view)

        listOfViews.append(title)
        listOfViews.append(self.firstNameInput)

        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func setupLastNameStackView() -> UIStackView {
        var listOfViews: [UIView] = []
        let title = LayoutController.getLabel(text: Utility.getString(forKey: "addStringer_lastName"), parentView: self.view)
        self.lastNameInput = LayoutController.getTextField(placeholder: "Doe", parentView: self.view)

        listOfViews.append(title)
        listOfViews.append(self.lastNameInput)

        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func setupEmailStackView() -> UIStackView {
        var listOfViews: [UIView] = []
        let title = LayoutController.getLabel(text: Utility.getString(forKey: "addStringer_email"), parentView: self.view)
        self.emailInput = LayoutController.getTextField(placeholder: "johndoe@example.com", parentView: self.view)

        listOfViews.append(title)
        listOfViews.append(self.emailInput)

        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func setupPhoneNumberStackView() -> UIStackView {
        var listOfViews: [UIView] = []
        let title = LayoutController.getLabel(text: Utility.getString(forKey: "addStringer_phoneNumber"), parentView: self.view)
        self.phoneNumerInput = LayoutController.getTextField(placeholder: "88772233", parentView: self.view)

        listOfViews.append(title)
        listOfViews.append(self.phoneNumerInput)

        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func setupPreferredRacketStackView() -> UIStackView {
        var listOfViews: [UIView] = []
        let title = LayoutController.getLabel(text: Utility.getString(forKey: "addStringer_preferredRacket"), parentView: self.view)
        self.preferredRacketTypeInput = LayoutController.getTextField(placeholder: "Tennis", parentView: self.view)

        listOfViews.append(title)
        listOfViews.append(self.preferredRacketTypeInput)

        return LayoutController.getStackView(content: listOfViews, orientation: .horizontal, parentView: self.view)
    }

    private func setupPickerView() {
        self.initPicker(picker: preferredRacketTypePicker, inputField: preferredRacketTypeInput)
    }

    private func setupConstraints() {
        Layout.addTopConstraint(on: self.mainStackView, to: self.view.safeAreaLayoutGuide.topAnchor)
        Layout.addLeadingConstraint(on: self.mainStackView, to: self.view.safeAreaLayoutGuide.leadingAnchor, by: Constant.bigOffset)
        Layout.addTrailingConstraint(on: self.mainStackView, to: self.view.safeAreaLayoutGuide.trailingAnchor, by: Constant.bigOffset)
    }

    private func dismiss() {
        DispatchQueue.main.async {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }

    private func initPicker(picker: UIPickerView, inputField: UITextField!) {
        picker.delegate = self
        picker.dataSource = self
        inputField.inputView = picker
    }

    private func createStringer() -> StringerDto? {
        let stringer = StringerDto.init(firstname: self.firstNameInput.text, lastName: self.lastNameInput.text, phoneNumber: self.phoneNumerInput.text, email: self.emailInput.text, preferredRacketType: self.chosenPurpose)

        return stringer
    }

    private func presentDefaultAlert() {
        DispatchQueue.main.async {
            let alert = LayoutController.getAlert(withTitle: Utility.getString(forKey: "common_Ups"), withMessage: Utility.getString(forKey: "specificOrder_one_step_error"))
            alert.addAction(UIAlertAction(title: Utility.getString(forKey: "common_ok"), style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }

    @objc func saveStringer() {
        let spinner = LayoutController.getSpinner(forParent: self.view)
        self.showSpinner(withSpinner: spinner)

        guard let stringer = createStringer() else {
            self.removeSpinner(forSpinner: spinner)
            self.presentDefaultAlert()
            return
        }

        ShopSingleton.shared.getShop { (shop) in
            if let shop = shop {
                self.teamController.postStringerToTeam(teamId: shop.teamId, with: stringer) { (success) in
                    if success {
                        self.dismiss()
                        self.delegate?.addStringerToTeam()
                    } else {
                        self.presentDefaultAlert()
                    }

                    self.removeSpinner(forSpinner: spinner)
                }
            } else {
                print("cannot find shop")
            }
        }
    }

    @objc func closeAction() {
        self.dismiss()
    }

    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension AddStringerToTeamViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if let racketTypes = self.racketTypes {
            return racketTypes.count
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let racketTypes = self.racketTypes {
            return racketTypes[row].purpose
        }

        return Constant.emptyString
    }
}

extension AddStringerToTeamViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let racketTypes = self.racketTypes {
            self.preferredRacketTypeInput.text = racketTypes[row].purpose
            self.chosenPurpose = racketTypes[row].id
        }
    }
}
