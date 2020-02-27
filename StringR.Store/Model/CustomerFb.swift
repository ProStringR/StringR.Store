//
//  Customer.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class CustomerFb: Codable {

    var userId: String
    var name: String
    var birthday: Int64
    var email: String
    var phoneNumber: String
    var orderIds: [String]?
    var preferedStringType: StringType
    var preferedTensionVertical: Double
    var prederedTensionHorizontal: Double

    init(userId: String, name: String, birthday: Int64, email: String, phoneNumber: String, preferedStringType: StringType, preferedTensionVertical: Double, prederedTensionHorizontal: Double) {
        self.userId = userId
        self.name = name
        self.birthday = birthday
        self.email = email
        self.phoneNumber = phoneNumber
        self.preferedStringType = preferedStringType
        self.preferedTensionVertical = preferedTensionVertical
        self.prederedTensionHorizontal = prederedTensionHorizontal
    }
}
