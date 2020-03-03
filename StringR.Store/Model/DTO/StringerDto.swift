//
//  StringerDto.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 03/03/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class StringerDto: Codable {
    var firstname: String
    var lastName: String
    var phoneNumber: String
    var email: String
    var preferredRacketType: Int

    init?(firstname: String?, lastName: String?, phoneNumber: String?, email: String?, preferredRacketType: Int?) {
        guard let firstname = firstname, let lastName = lastName, let phoneNumber = phoneNumber, let email = email, let preferredRacketType = preferredRacketType else {
            print("something is wrong with the dto")
            return nil
        }

        self.firstname = firstname
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email
        self.preferredRacketType = preferredRacketType
    }
}
