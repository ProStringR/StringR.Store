//
//  Stringer.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class Stringer: User {

    var address: Address
    var preferedRacketType: Racket.RacketType

    init(userId: String, name: String, birthday: Double, email: String, phoneNumber: String, orderIds: [String], address: Address, preferedRacketType: Racket.RacketType) {
        self.address = address
        self.preferedRacketType = preferedRacketType

        super.init(userId: userId, name: name, birthday: birthday, email: email, phoneNumber: phoneNumber, orderIds: orderIds)
    }

}
