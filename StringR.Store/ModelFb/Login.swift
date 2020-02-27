//
//  Login.swift
//  StringR.Store
//
//  Created by Jaafar on 29/11/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

struct Login: Codable {
    var email: String
    var password: String

    init(userName: String, password: String) {
        self.email = userName
        self.password = password
    }
}
