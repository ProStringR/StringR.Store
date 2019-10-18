//
//  Shop.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class Shop: Codable {

    var shopId: String
    var address: Address
    var phoneNumber: String
    var storageId: String
    var teamId: String
    var companyId: String
    var orderIds: [String]?

    init(shopId: String, address: Address, phoneNumber: String, storageId: String, teamId: String, companyId: String) {
        self.shopId = shopId
        self.address = address
        self.phoneNumber = phoneNumber
        self.storageId = storageId
        self.teamId = teamId
        self.companyId = companyId
    }
}
