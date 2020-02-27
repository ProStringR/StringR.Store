//
//  OrderHistory.swift
//  StringR.Store
//
//  Created by Jaafar on 25/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class OrderHistoryFb: Codable {
    var date: Int64
    var paid: Bool
    var orderStatus: OrderStatus

    init(date: Int64, paid: Bool, orderStatus: OrderStatus) {
        self.date = date
        self.paid = paid
        self.orderStatus = orderStatus
    }
}
