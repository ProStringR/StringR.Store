//
//  Order.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

struct Order {

    var orderId: String
    var customerId: String
    var stringerId: String
    var racketType: Racket.RacketType
    var tensionVertical: Double
    var tensionHorizontal: Double
    var stringId: String
    var deliveryDate: Double
    var price: Double
    var paid: Bool
    var timePlaced: Double?
    var timeDone: Double?
    var timeDelivery: Double?
    var comment: String?

    init(orderId: String, customerId: String, stringerId: String, racketType: Racket.RacketType, tensionVertical: Double, tensionHorizontal: Double, stringId: String, deliveryDate: Double, price: Double, paid: Bool) {
        self.orderId = orderId
        self.customerId = customerId
        self.stringerId = stringerId
        self.racketType = racketType
        self.tensionVertical = tensionVertical
        self.tensionHorizontal = tensionHorizontal
        self.stringId = stringId
        self.deliveryDate = deliveryDate
        self.price = price
        self.paid = paid
    }
}
