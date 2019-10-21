//
//  AddStringStoragePopUpViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 22/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class AddStringToStorageViewController: UIViewController {
    weak var delegate: UpdateStorageDelegate?

    weak var brandLabel: UILabel!
    weak var brandInput: UITextField!
    weak var modelLabel: UILabel!
    weak var modelInput: UITextField!
    weak var stringTypeLabel: UILabel!
    weak var stringTypeInput: UITextField!
    weak var colorLabel: UILabel!
    weak var colorInput: UITextField!
    weak var stringPurposeLabel: UILabel!
    weak var stringPurposeInput: UITextField!
    weak var thicknessLabel: UILabel!
    weak var thicknessInput: UITextField!
    weak var lengthLabel: UILabel!
    weak var lengthInput: UITextField!
    weak var buyPriceLabel: UILabel!
    weak var buyPriceInput: UITextField!
    weak var buyDateLabel: UILabel!
    weak var buyDateInput: UITextField!
    weak var pricePerRacketLabel: UILabel!
    weak var pricePerRacketInput: UITextField!

    weak var generelStackView: UIStackView!
    weak var addButton: UIButton!

    let brands = StringBrand.allValues
    let colors = StringColor.allValues
    let types = StringType.allValues
    let purpose = RacketType.allValues

    var brandPicker = UIPickerView()
    var colorPicker = UIPickerView()
    var typePicker = UIPickerView()
    var purposePicker = UIPickerView()
    var datePicker = UIDatePicker()

    var buyDate: Date?

    let storageController = ControlReg.getStorageController

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        initializeLabels()
        initializeTextFields()
        initializeStackView()
        setupPickers()
        setupStackView()
        setConstraints()

        // set tapGesture to close keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }

    private func setupLayout() {
        self.view.backgroundColor = .white
        self.view.layer.cornerRadius = 10
        self.title = Utility.getString(forKey: "addString_Head")
        self.navigationController?.hideNavigationBar()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addAction))
    }

    private func initializeLabels() {
        self.brandLabel = initLabel(text: Utility.getString(forKey: "addString_BrandLabel"))
        self.modelLabel = initLabel(text: Utility.getString(forKey: "addString_ModelLabel"))
        self.stringTypeLabel = initLabel(text: Utility.getString(forKey: "addString_StringTypeLabel"))
        self.colorLabel = initLabel(text: Utility.getString(forKey: "addString_ColorLabel"))
        self.stringPurposeLabel = initLabel(text: Utility.getString(forKey: "addString_StringPurposeLabel"))
        self.thicknessLabel = initLabel(text: Utility.getString(forKey: "addString_ThicknessLabel"))
        self.lengthLabel = initLabel(text: Utility.getString(forKey: "addString_LengthLabel"))
        self.buyPriceLabel = initLabel(text: Utility.getString(forKey: "addString_BuyPriceLabel"))
        self.buyDateLabel = initLabel(text: Utility.getString(forKey: "addString_BuyDateLabel"))
        self.pricePerRacketLabel = initLabel(text: Utility.getString(forKey: "addString_PricePerRacketLabel"))
    }

    private func initializeTextFields() {
        self.brandInput = initTextField(placeholder: Utility.getString(forKey: "addString_BrandPlaceholder"))
        self.modelInput = initTextField(placeholder: Utility.getString(forKey: "addString_ModelPlaceholder"))
        self.stringTypeInput = initTextField(placeholder: Utility.getString(forKey: "addString_StringTypePlaceholder"))
        self.colorInput = initTextField(placeholder: Utility.getString(forKey: "addString_ColorPlaceholder"))
        self.stringPurposeInput = initTextField(placeholder: Utility.getString(forKey: "addString_StringPurposePlaceholder"))
        self.thicknessInput = initTextField(placeholder: Utility.getString(forKey: "addString_ThicknessPlaceholder"))
        self.lengthInput = initTextField(placeholder: Utility.getString(forKey: "addString_LengthPlaceholder"))
        self.buyPriceInput = initTextField(placeholder: Utility.getString(forKey: "addString_BuyPricePlaceholder"))
        self.buyDateInput = initTextField(placeholder: Utility.getString(forKey: "addString_BuyDatePlaceholder"))
        self.pricePerRacketInput = initTextField(placeholder: Utility.getString(forKey: "addString_PricePerRacketPlaceholder"))
    }

    private func initializeStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        self.view.addSubview(stackView)
        self.generelStackView = stackView
    }

    private func setupPickers() {
        initPicker(picker: self.brandPicker, inputField: self.brandInput)
        initPicker(picker: self.colorPicker, inputField: self.colorInput)
        initPicker(picker: self.typePicker, inputField: self.stringTypeInput)
        initPicker(picker: self.purposePicker, inputField: self.stringPurposeInput)

        // setup date picker
        self.datePicker.datePickerMode = .date
        self.datePicker.addTarget(self, action: #selector(dataChanged(datePicker:)), for: .valueChanged)
        self.buyDateInput.inputView = self.datePicker
    }

    private func setupStackView() {
        self.generelStackView.addArrangedSubview(initStackView(label: self.brandLabel, textfield: self.brandInput))
        self.generelStackView.addArrangedSubview(initStackView(label: self.modelLabel, textfield: self.modelInput))
        self.generelStackView.addArrangedSubview(initStackView(label: self.stringTypeLabel, textfield: self.stringTypeInput))
        self.generelStackView.addArrangedSubview(initStackView(label: self.colorLabel, textfield: self.colorInput))
        self.generelStackView.addArrangedSubview(initStackView(label: self.stringPurposeLabel, textfield: self.stringPurposeInput))
        self.generelStackView.addArrangedSubview(initStackView(label: self.thicknessLabel, textfield: self.thicknessInput))
        self.generelStackView.addArrangedSubview(initStackView(label: self.lengthLabel, textfield: self.lengthInput))
        self.generelStackView.addArrangedSubview(initStackView(label: self.buyPriceLabel, textfield: self.buyPriceInput))
        self.generelStackView.addArrangedSubview(initStackView(label: self.buyDateLabel, textfield: self.buyDateInput))
        self.generelStackView.addArrangedSubview(initStackView(label: self.pricePerRacketLabel, textfield: self.pricePerRacketInput))
    }

    private func setConstraints() {
        Layout.setupFullPageConstraints(forView: self.generelStackView, onParentView: self.view, by: Constant.bigOffset)
    }

    private func initPicker(picker: UIPickerView, inputField: UITextField!) {
        picker.delegate = self
        picker.dataSource = self
        inputField.inputView = picker
    }

    private func initStackView(label: UILabel!, textfield: UITextField!) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constant.standardOffset
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textfield)
        stackView.distribution = .fillEqually

        return stackView
    }

    private func initTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        self.view.addSubview(textField)

        return textField
    }

    private func initLabel(text: String) -> UILabel {
        let tempLabel = UILabel()
        tempLabel.text = text
        self.view.addSubview(tempLabel)

        return tempLabel
    }

    private func createStringToAdd() -> RacketString? {
        return RacketString.init(stringId: Utility.getUUID(), brand: brandInput.text, modelName: modelInput.text, stringType: stringTypeInput.text, length: lengthInput.text, buyDate: datePicker.date.millisecondsSince1970, buyPrice: buyPriceInput.text, pricePerRacket: pricePerRacketInput.text, thickness: thicknessInput.text, color: colorInput.text, stringPurpose: stringPurposeInput.text)
    }

    @objc func cancelAction() {
        DispatchQueue.main.async {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }

    @objc func addAction() {
        let stringToAdd = createStringToAdd()

        if let stringToAdd = stringToAdd {
            let storageId = "ShopMJ"
            storageController.putRacketString(racketString: stringToAdd, storageId: storageId) { (succes) in
                if succes {
                    print("Jeg kalder Delegate")
                    self.delegate?.addString(string: stringToAdd)
                } else {
                    print("cant put it in firebase")
                }
            }
        } else {
            print("something went wrong")
        }
    }

    @objc func dataChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        self.buyDateInput.text = dateFormatter.string(from: datePicker.date)
        self.buyDate = datePicker.date
    }

    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension AddStringToStorageViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case self.brandPicker:
            return self.brands.count
        case self.colorPicker:
            return self.colors.count
        case self.typePicker:
            return self.types.count
        case self.purposePicker:
            return self.purpose.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case self.brandPicker:
            return self.brands[row].rawValue
        case self.colorPicker:
            return self.colors[row].rawValue
        case self.typePicker:
            return self.types[row].rawValue
        case self.purposePicker:
            return self.purpose[row].rawValue
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case self.brandPicker:
            self.brandInput.text = self.brands[row].rawValue
        case self.colorPicker:
            self.colorInput.text = self.colors[row].rawValue
        case self.typePicker:
            self.stringTypeInput.text = self.types[row].rawValue
        case self.purposePicker:
            self.stringPurposeInput.text = self.purpose[row].rawValue
        default:
            print("Default")
        }
    }
}
