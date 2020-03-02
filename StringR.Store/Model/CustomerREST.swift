//
//  CustomerREST.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 02/03/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class CustomerREST: Codable {
    var customerId: Int
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var preferredStringType: String
    var preferredTensionVertical: Double
    var preferredTensionHorizontal: Double

    init(customerId: Int, firstName: String, lastName: String, email: String, phoneNumber: String, preferredStringType: String, preferredTensionVertical: Double, preferredTensionHorizontal: Double) {
        self.customerId = customerId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.preferredStringType = preferredStringType
        self.preferredTensionVertical = preferredTensionVertical
        self.preferredTensionHorizontal = preferredTensionHorizontal
    }
}
