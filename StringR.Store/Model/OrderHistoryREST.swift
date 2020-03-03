//
//  OrderHistoryREST.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 02/03/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class OrderHistoryREST: Codable {
    var id: Int?
    var orderId: Int
    var transactionDate: Int64
    var paid: Bool
    var orderStatus: Int

    init(orderId: Int, transactionDate: Int64, paid: Bool, orderStatus: Int) {
        self.orderId = orderId
        self.transactionDate = transactionDate
        self.paid = paid
        self.orderStatus = orderStatus
    }
}
