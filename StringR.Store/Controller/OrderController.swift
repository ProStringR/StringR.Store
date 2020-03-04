//
//  OrderController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 19/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class OrderController {

    let orderDAO: OrderDAOProtocol = ControlReg.getOrderDAO

    func postOrder(order: OrderDto, completion: @escaping (Bool) -> Void) {
        orderDAO.postOrder(order: order) { (success) in
            completion(success)
        }
    }

    func getAllOrdersWithStatus(shopId: String, withStatus orderStatus: Int, completion: @escaping ([OrderREST]?) -> Void) {
        orderDAO.getAllOrders(shopId: shopId, withStatus: orderStatus) { (orders) in
            completion(orders)
        }
    }

    func putOrderHistoryItem(for orderHistoryItem: OrderHistoryREST, completion: @escaping (Bool) -> Void) {
        orderDAO.putOrderHistoryItem(for: orderHistoryItem) { (success) in
            completion(success)
        }
    }
}
