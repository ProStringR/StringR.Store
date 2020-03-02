//
//  OrderDto.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 02/03/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class OrderDto: Codable {
    var customerId: Int
    var stringerId: Int
    var shopId: Int
    var racketModel: String
    var racketBrand: Int
    var tensionVertical: Double
    var tensionHorizontal: Double
    var stringId: Int
    var deliveryDate: Int64
    var price: Double
    var comment: String?
    var datePlaced: Int64

    init(customerId: Int, stringerId: Int, shopId: Int, racketModel: String, racketBrand: Int, tensionVertical: String, tensionHorizontal: String, stringId: Int, deliveryDate: Int64, price: Double, comment: String?, datePlaced: Int64) {
        self.customerId = customerId
        self.stringerId = stringerId
        self.shopId = shopId
        self.racketModel = racketModel
        self.racketBrand = racketBrand
        self.tensionVertical = Double(tensionVertical) ?? 0
        self.tensionHorizontal = Double(tensionHorizontal) ?? 0
        self.stringId = stringId
        self.deliveryDate = deliveryDate
        self.price = price
        self.comment = comment
        self.datePlaced = datePlaced
    }
}
