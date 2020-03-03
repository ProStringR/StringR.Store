//
//  OrderREST.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 02/03/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class OrderREST: Codable {
    var id: Int
    var orderStatus: Int
    var comment: String?
    var price: Double
    var paid: Bool
    var deliveryDate: Int64
    var tensionVertical: Double
    var tensionHorizontal: Double
    var customer: OrderCustomerREST
    var stringer: OrderStringerREST
    var racket: RacketREST
    var racketString: OrderRacketStringREST
    var orderHistory: [OrderHistoryREST]

    var daysToDeliver: Int {
            let diff = Int(self.deliveryDate - Date().millisecondsSince1970)
            let daysToDeliver = diff / (86400000)
            return daysToDeliver
    }
}
