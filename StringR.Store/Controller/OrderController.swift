//
//  OrderController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 19/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class OrderController {

    let orderDAO: OrderDAOProtocol = OrderDAOFirebase()

    func getActiveOrders() throws -> [Order] {
        do {
            let orders: [OrderDTO] = try orderDAO.getActiveOrders()
            var activeOrders = [Order]()

            for order in orders {
                activeOrders.append(Order.init(orderDTO: order))
            }

            return activeOrders

        } catch {
            throw error
        }
    }

}
