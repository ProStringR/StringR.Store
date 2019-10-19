//
//  OrderDTO.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 19/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

struct OrderDTO: Codable {

    var orderId: String?
    var customerId: String?
    var stringerId: String?
    var shopId: String?
    var racketType: RacketType?
    var tensionVertical: Double?
    var tensionHorizontal: Double?
    var stringId: String?
    var deliveryDate: Int64?
    var price: Double?
    var paid: Bool?
    var timePlaced: Int64?
    var timeDone: Int64?
    var timeDelivery: Int64?
    var comment: String?
    var orderStatus: OrderStatus?
}
