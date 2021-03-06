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
    var shopId: String
    var racketId: String
    var racketType: RacketType
    var tensionVertical: Double
    var tensionHorizontal: Double
    var stringId: String
    var deliveryDate: Int64
    var price: Double
    var paid: Bool
    var orderStatus: OrderStatus
    var orderHistory: [OrderHistory]?
    var timePlaced: Int64?
    var timeDone: Int64?
    var timeDelivery: Int64?
    var comment: String?
    var stringer: Stringer?
    var customer: Customer?
    var racketString: RacketString?
    var shop: Shop?
    var racket: Racket?
    var daysToDeliver: Int {
            let diff = Int(self.deliveryDate - Date().millisecondsSince1970)
            let daysToDeliver = diff / (86400000)
            return daysToDeliver
    }

    init(orderId: String, customerId: String, stringerId: String, shopId: String, racketId: String, racketType: RacketType, tensionVertical: Double, tensionHorizontal: Double, stringId: String, deliveryDate: Int64, price: Double, paid: Bool) {
        self.orderId = orderId
        self.customerId = customerId
        self.stringerId = stringerId
        self.shopId = shopId
        self.racketId = racketId
        self.racketType = racketType
        self.tensionVertical = tensionVertical
        self.tensionHorizontal = tensionHorizontal
        self.stringId = stringId
        self.deliveryDate = deliveryDate
        self.price = price
        self.paid = paid
        self.orderStatus = .RECEIVED
    }

    init?(orderId: String?, customerId: String?, stringerId: String?, shopId: String?, racketId: String?, racketType: RacketType?, tensionVertical: Double?, tensionHorizontal: Double?, stringId: String?, deliveryDate: Int64?, price: Double?, paid: Bool?) {

        guard let orderId = orderId, let customerId = customerId, let stringerId = stringerId, let shopId = shopId, let racketId = racketId, let racketType = racketType, let tensionVertical = tensionVertical, let tensionHorizontal = tensionHorizontal, let stringId = stringId, let deliveryDate = deliveryDate, let price = price, let paid = paid else { return nil }

        self.orderId = orderId
        self.customerId = customerId
        self.stringerId = stringerId
        self.shopId = shopId
        self.racketId = racketId
        self.racketType = racketType
        self.tensionVertical = tensionVertical
        self.tensionHorizontal = tensionHorizontal
        self.stringId = stringId
        self.deliveryDate = deliveryDate
        self.price = price
        self.paid = paid
        self.orderStatus = .RECEIVED

        let timePlaced = Date().millisecondsSince1970
        self.timePlaced = timePlaced

        self.orderHistory = [OrderHistory.init(date: timePlaced, paid: self.paid, orderStatus: self.orderStatus)]
    }
}
