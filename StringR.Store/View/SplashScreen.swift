//
//  SplashScreen.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 31/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit
import JWTDecode

class SplashScreen: UIViewController {

    weak var logo: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLogo()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigate()
    }

    private func setupView() {
        self.view.backgroundColor = .black
    }

    private func setupLogo() {
        let logo = UIImageView()
        logo.image = #imageLiteral(resourceName: "splashScreenLogo")
        self.view.addSubview(logo)

        self.logo = logo
    }

    private func setupConstraints() {
        Layout.centerVertically(on: self.logo, withParent: self.view)
        Layout.centerHorizontally(on: self.logo, withParent: self.view)
    }

    private func navigate() {
        sleep(2)

        var jwt: JWT?

        do {
            jwt = try decode(jwt: Utility.readStringFromSharedPref(Constant.token))
        } catch {
            print(error)
        }

        var viewController: UIViewController

        if let jwt = jwt {
            if jwt.expired {
                viewController = SignInViewController()
            } else {
                viewController = RootTabBarController()
            }
        } else {
            viewController = SignInViewController()
        }

        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}
