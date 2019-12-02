//
//  AuthenticationDAOProtocol.swift
//  StringR.Store
//
//  Created by Jaafar on 29/11/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol AuthenticationDAOProtocol {
    func authenticateShop(login: Login, completion: @escaping (LoginResponse?) -> Void)
}
