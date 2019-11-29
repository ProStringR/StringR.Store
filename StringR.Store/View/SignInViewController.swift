//
//  SignInViewControllerViewController.swift
//  StringR.Store
//
//  Created by Jaafar on 29/11/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    weak var stackView: UIStackView!
    weak var logo: UIImageView!
    weak var button: UIButton!
    weak var userNameTextField: UITextField!
    weak var passwordTextField: UITextField!

    let authenticationController = ControlReg.getAuthenticationController

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setupCredentialsStackView()
        setupLogo()
        setupButton()
        setupConstraints()

        // set tapGesture to close keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
    }

    private func setLayout() {
        self.view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        Layout.setupViewNavigationController(forView: self, withTitle: "Sign In")
    }

    private func setupLogo() {
        let logo = UIImageView()
        logo.image = #imageLiteral(resourceName: "Image")
        self.view.addSubview(logo)

        self.logo = logo
    }

    private func setupCredentialsStackView() {
        var listOfViews: [UIView] = []

        let userNameLabel = LayoutController.getLabel(text: "User Name", parentView: self.view)
        let passwordLabel = LayoutController.getLabel(text: "Password", parentView: self.view)
        Layout.centerAlignUILabels(uiLabelArry: [userNameLabel, passwordLabel])
        Layout.setLabelAsHeader(labels: [userNameLabel, passwordLabel])

        self.userNameTextField = LayoutController.getTextField(placeholder: "User Name", parentView: self.view)
        self.passwordTextField = LayoutController.getTextField(placeholder: "Password", parentView: self.view)

        listOfViews.append(userNameLabel)
        listOfViews.append(self.userNameTextField)
        listOfViews.append(passwordLabel)
        listOfViews.append(self.passwordTextField)

        self.stackView = LayoutController.getStackView(content: listOfViews, orientation: .vertical, parentView: self.view)
        self.stackView.alignment = .fill
        self.stackView.spacing = Constant.bigOffset
    }

    private func setupButton() {
        self.button = LayoutController.getButton(title: "Sign In", parentView: self.view)
        self.button.addTarget(self, action: #selector(onSignInPressed(_:)), for: .touchUpInside)
    }

    private func setupConstraints() {
        let specialOffset = Constant.gigantOffset * 2
        Layout.addTopConstraint(on: self.logo, to: self.view.safeAreaLayoutGuide.topAnchor, by: specialOffset)
        Layout.centerHorizontally(on: self.logo, withParent: self.view)

        Layout.addTopConstraint(on: self.stackView, to: self.logo.bottomAnchor, by: Constant.gigantOffset)
        Layout.addLeadingConstraint(on: self.stackView, to: self.view.safeAreaLayoutGuide.leadingAnchor, by: specialOffset)
        Layout.addTrailingConstraint(on: self.stackView, to: self.view.safeAreaLayoutGuide.trailingAnchor, by: specialOffset)

        Layout.addTopConstraint(on: self.button, to: self.stackView.bottomAnchor, by: specialOffset)
        Layout.addLeadingConstraint(on: self.button, to: self.view.safeAreaLayoutGuide.leadingAnchor, by: specialOffset)
        Layout.addTrailingConstraint(on: self.button, to: self.view.safeAreaLayoutGuide.trailingAnchor, by: specialOffset)
    }

    private func navigateToMainView() {
        DispatchQueue.main.async {
            let viewController = RootTabBarController()
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true, completion: nil)
        }
    }

    private func presentDefaultAlert() {
        DispatchQueue.main.async {
            let alert = LayoutController.getAlert(withTitle: Utility.getString(forKey: "common_Ups"), withMessage: Constant.emptyString)
            alert.addAction(UIAlertAction(title: Utility.getString(forKey: "common_ok"), style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }

    @objc func onSignInPressed(_ sender: UIButton) {
        if let userName = self.userNameTextField.text, let password = self.passwordTextField.text {
            if userName.isEmpty || password.isEmpty {

            }

            let login: Login = Login.init(userName: userName, password: password)

            let spinner = LayoutController.getSpinner(forParent: self.view)
            authenticationController.authenticateShop(login: login) { (token) in
                self.showSpinner(withSpinner: spinner)
                if let token = token {
                    Utility.writeStringToSharedPref(withKey: Constant.token, value: token)
                    self.navigateToMainView()
                } else {
                    self.presentDefaultAlert()
                }

                self.removeSpinner(forSpinner: spinner)
            }
        }
    }

    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
