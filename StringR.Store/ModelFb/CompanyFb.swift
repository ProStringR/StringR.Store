//
//  Company.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class CompanyFb: Codable {

    var companyId: String
    var shopId: [String]
    var name: String
    var email: String
    var phoneNumber: String

    init(companyId: String, shopId: [String], name: String, email: String, phoneNumber: String) {
        self.companyId = companyId
        self.shopId = shopId
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
    }
}
