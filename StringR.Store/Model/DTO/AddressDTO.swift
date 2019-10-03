//
//  AddressDTO.swift
//  StringR.Store
//
//  Created by Jaafar on 01/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

struct AddressDTO: Codable {

    var street: String?
    var zipCode: String?
    var city: String?
    var country: String?
    var longitude: Double?
    var latitude: Double?
}
