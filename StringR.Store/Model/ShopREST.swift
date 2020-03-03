//
//  ShopREST.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 03/03/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class ShopREST: Codable {
    var id: Int
    var teamId: Int
    var phoneNumber: String
    var address: AddressREST
}
