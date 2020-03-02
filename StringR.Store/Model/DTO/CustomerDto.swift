//
//  CustomerDto.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 02/03/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class CustomerDto: Codable {
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var password: String
    var preferredStringTypeId: Int
    var preferredTensionVertical: Double
    var preferredTensionHorizontal: Double

    init(firstName: String, lastName: String, email: String, phoneNumber: String, password: String, preferredStringTypeId: Int, preferredTensionVertical: Double, preferredTensionHorizontal: Double) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.password = password
        self.preferredStringTypeId = preferredStringTypeId
        self.preferredTensionVertical = preferredTensionVertical
        self.preferredTensionHorizontal = preferredTensionHorizontal
    }
}
