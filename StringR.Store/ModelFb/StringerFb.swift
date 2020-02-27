//
//  Stringer.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class StringerFb: Codable {

    var userId: String
    var name: String
    var email: String
    var phoneNumber: String
    var preferedRacketType: RacketType
    var orderIds: [String]?

    init(userId: String, name: String, email: String, phoneNumber: String, preferedRacketType: RacketType) {
        self.userId = userId
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.preferedRacketType = preferedRacketType
    }

    init?(firstName: String?, lastName: String?, email: String?, phoneNumber: String?, preferredRacketType: String?) {
        guard let firstName = firstName, let lastName = lastName, let email = email, let phoneNumber = phoneNumber, let preferredRacketType = preferredRacketType else { return nil }

        if firstName.isEmpty || lastName.isEmpty || email.isEmpty || phoneNumber.isEmpty || preferredRacketType.isEmpty {
            return nil
        }

        self.userId = Utility.getUUID()
        self.name = "\(firstName) \(lastName)"
        self.email = email
        self.phoneNumber = phoneNumber

        if let racketType = RacketType(rawValue: preferredRacketType) {
            self.preferedRacketType = racketType
        } else {
            return nil
        }
    }
}
