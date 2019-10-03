//
//  Address.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class Address: Codable {

    var street: String
    var zipCode: String
    var city: String
    var country: String
    var longitude: Double
    var latitude: Double

    init(street: String, zipCode: String, city: String, country: String, longitude: Double, latitude: Double) {
        self.street = street
        self.zipCode = zipCode
        self.city = city
        self.country = country
        self.longitude = longitude
        self.latitude = latitude
    }
}
