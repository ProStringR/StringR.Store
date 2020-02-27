//
//  StringerDTO.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 30/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

struct StringerDTOFb: Codable {

    var userId: String?
    var name: String?
    var birthday: Int64?
    var email: String?
    var phoneNumber: String?
    var address: AddressFb?
    var preferedRacketType: RacketType?
    var orderIds: [String]?
}
