//
//  OrderStatus.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 18/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

enum OrderStatus: String, Codable {
    case RECIEVED = "Recieved"
    case DONE = "Done"
    case DELIVERED = "Delivered"
    case COMPLETE = "Complete"
}

extension OrderStatus {
    static var allValues: [OrderStatus] {
        var allValues: [OrderStatus] = []
        switch OrderStatus.RECIEVED {
        case .RECIEVED: allValues.append(.RECIEVED); fallthrough
        case .DONE: allValues.append(.DONE); fallthrough
        case .DELIVERED: allValues.append(.DELIVERED); fallthrough
        case .COMPLETE: allValues.append(.COMPLETE)
        }
        return allValues
    }
}
