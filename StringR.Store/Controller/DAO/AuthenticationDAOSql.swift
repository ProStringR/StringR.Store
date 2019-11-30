//
//  AuthenticationDAOSql.swift
//  StringR.Store
//
//  Created by Jaafar on 29/11/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class AuthenticationDAOSql: AuthenticationDAOProtocol {
    let dataControl = ControlReg.getDataController

    func authenticateShop(login: Login, completion: @escaping (String?) -> Void) {
        dataControl.authenticateShop(body: login, url: Constant.authenticationUrl) { (token) in
            completion(token)
        }
    }
}
