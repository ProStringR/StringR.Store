//
//  AddressREST.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 03/03/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class AddressREST: Codable {
    var zipCode: String
    var city: String
    var country: String
    var longitude: Double
    var latitude: Double
    var street: String
    var addressNumber: String
}
