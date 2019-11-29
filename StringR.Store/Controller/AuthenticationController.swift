//
//  AuthenticationController.swift
//  StringR.Store
//
//  Created by Jaafar on 29/11/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class AuthenticationController {

    let authenticationDAO: AuthenticationDAOProtocol = ControlReg.getAuthenticationDAO

    func authenticateShop(login: Login, completion: @escaping (String?) -> Void) {
        authenticationDAO.authenticateShop(login: login) { (token) in
            completion(token)
        }
    }
}
