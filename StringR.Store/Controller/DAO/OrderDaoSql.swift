//
//  OrderDaoSql.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 02/03/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class OrderDaoSql: OrderDAOProtocol {
    let dataControl = ControlReg.getDataController

    func postOrder(order: OrderDto, completion: @escaping (Bool) -> Void) {
        dataControl.postDataREST(object: order, url: Constant.orders) { (success) in
            completion(success)
        }
    }

    func getAllOrders(shopId: String, withStatus orderStatus: Int, completion: @escaping ([OrderREST]?) -> Void) {
        dataControl.getDataREST(returnType: [OrderREST].self, url: "\(Constant.orders)/shop/\(shopId)/\(orderStatus)") { (orders) in
            completion(orders)
        }
    }

    func putOrderHistoryItem(for historyItem: OrderHistoryREST, completion: @escaping (Bool) -> Void) {
        dataControl.putDataREST(object: historyItem, url: Constant.orders) { (success) in
            completion(success)
        }
    }
}
