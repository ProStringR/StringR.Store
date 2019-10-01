//
//  StringerDTO.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 30/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class StringerDTO: Codable {
    var userId: String?
    var name: String?
    var birthday: Int64?
    var email: String?
    var phoneNumber: String?
    var address: Address?
    var preferedRacketType: RacketType?
    var orderIds: [String]?
}
