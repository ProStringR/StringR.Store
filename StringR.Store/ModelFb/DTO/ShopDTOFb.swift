//
//  Shop.swift
//  StringR.Store
//
//  Created by Jaafar on 03/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

struct ShopDTOFb: Codable {

    var shopId: String?
    var address: AddressFb?
    var phoneNumber: String?
    var storageId: String?
    var teamId: String?
    var companyId: String?
    var orderIds: [String]?
}
