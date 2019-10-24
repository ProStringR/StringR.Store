//
//  OrderStatus.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 18/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

enum OrderStatus: String, Codable {
    case RECEIVED = "Received"
    case DONE = "Done"
    case DELIVERED = "Delivered"
    case COMPLETE = "Complete"
}

extension OrderStatus {
    static var allValues: [OrderStatus] {
        var allValues: [OrderStatus] = []
        switch OrderStatus.RECEIVED {
        case .RECEIVED: allValues.append(.RECEIVED); fallthrough
        case .DONE: allValues.append(.DONE); fallthrough
        case .DELIVERED: allValues.append(.DELIVERED); fallthrough
        case .COMPLETE: allValues.append(.COMPLETE)
        }
        return allValues
    }

    static func indexOfOrderStatus(orderStatus: OrderStatus) -> Int {
        return OrderStatus.allValues.firstIndex(of: orderStatus) ?? 0
    }
}
