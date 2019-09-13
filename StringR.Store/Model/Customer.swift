//
//  Customer.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class Customer: User {

    var preferedStringType: StringType
    var preferedTensionVertical: Double
    var prederedTensionHorizontal: Double

    init(userId: String, name: String, birthday: Double, email: String, phoneNumber: String, orderIds: [String], preferedStringType: StringType, preferedTensionVertical: Double, prederedTensionHorizontal: Double) {
        self.preferedStringType = preferedStringType
        self.preferedTensionVertical = preferedTensionVertical
        self.prederedTensionHorizontal = prederedTensionHorizontal

        super.init(userId: userId, name: name, birthday: birthday, email: email, phoneNumber: phoneNumber, orderIds: orderIds)
    }
}
