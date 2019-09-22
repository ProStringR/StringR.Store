//
//  AddStringStoragePopUpViewController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 22/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class AddStringStoragePopUpViewController: UIViewController {

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

    let brands = StringBrand.allValues
    let colors = StringColor.allValues
    let types = StringType.allValues
    let purpose = RacketType.allValues

    var brandPicker = UIPickerView()
    var colorPicker = UIPickerView()
    var typePicker = UIPickerView()
    var purposePicker = UIPickerView()
    var datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        initializeLabels()
        initializeTextFields()
    }

    private func setupLayout() {
        self.view.backgroundColor = .white
        self.title = Utility.getString(forKey: "addString_Head")
        self.navigationController?.hideNavigationBar()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
    }

    private func initializeLabels() {
        self.brandLabel = initLabel(text: Utility.getString(forKey: "addString_BrandLabel"))
        self.modelLabel = initLabel(text: Utility.getString(forKey: "addString_ModelLabel"))
        self.stringTypeLabel = initLabel(text: Utility.getString(forKey: "addString_StringTypeLabel"))
        self.colorLabel = initLabel(text: Utility.getString(forKey: "addString_ColorLabel"))
        self.stringPurposeLabel = initLabel(text: Utility.getString(forKey: "addString_StringPurposeLabel"))
        self.thicknessLabel = initLabel(text: Utility.getString(forKey: "addString_ThicknessLabel"))
        self.lengthLabel = initLabel(text: Utility.getString(forKey: "addString_LengthLabel"))
        self.buyPriceLabel = initLabel(text: Utility.getString(forKey: "addString_BuyPrice"))
        self.buyDateLabel = initLabel(text: Utility.getString(forKey: "addString_BuyDate"))
        self.pricePerRacketLabel = initLabel(text: Utility.getString(forKey: "addString_PricePerRacket"))
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

    private func initTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textAlignment = .center
        self.view.addSubview(textField)

        return textField
    }

    private func initLabel(text: String) -> UILabel {
        let tempLabel = UILabel()
        tempLabel.text = text
        self.view.addSubview(tempLabel)

        return tempLabel
    }

    @objc func cancelAction() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

}
