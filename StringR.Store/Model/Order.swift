//
//  Order.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class Order: Codable {

    var orderId: String
    var customerId: String
    var stringerId: String
    var racketType: RacketType
    var tensionVertical: Double
    var tensionHorizontal: Double
    var stringId: String
    var deliveryDate: Int64
    var price: Double
    var paid: Bool
    var orderStatus: OrderStatus
    var timePlaced: Int64?
    var timeDone: Int64?
    var timeDelivery: Int64?
    var comment: String?
    var stringer: Stringer?
    var customer: Customer?
    var racketString: RacketString?

    init(orderId: String, customerId: String, stringerId: String, racketType: RacketType, tensionVertical: Double, tensionHorizontal: Double, stringId: String, deliveryDate: Int64, price: Double, paid: Bool) {
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
        self.orderStatus = .RECIEVED
    }

    init?(orderId: String?, customerId: String?, stringerId: String?, racketType: RacketType?, tensionVertical: Double?, tensionHorizontal: Double?, stringId: String?, deliveryDate: Int64?, price: Double?, paid: Bool?) {

        guard let orderId = orderId, let customerId = customerId, let stringerId = stringerId, let racketType = racketType, let tensionVertical = tensionVertical, let tensionHorizontal = tensionHorizontal, let stringId = stringId, let deliveryDate = deliveryDate, let price = price, let paid = paid else { return nil }

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
        self.orderStatus = .RECIEVED
    }
}
