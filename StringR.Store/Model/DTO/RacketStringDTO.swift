//
//  RacketStringDTO.swift
//  StringR.Store
//
//  Created by Jaafar on 01/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

struct RacketStringDTO: Codable {

    var stringId: String?
    var brand: StringBrand?
    var modelName: String?
    var stringType: StringType?
    var length: Double?
    var buyDate: Int64?
    var buyPrice: Double?
    var pricePerRacket: Double?
    var thickness: Double?
    var color: StringColor?
    var stringPurpose: RacketType?
    var purchaseHistory: [PurchaseHistory]?
}
