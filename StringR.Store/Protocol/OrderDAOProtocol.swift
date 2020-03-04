//
//  OrderDAOProtocol.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 19/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol OrderDAOProtocol {
    func postOrder(order: OrderDto, completion: @escaping (Bool) -> Void)
    func getAllOrders(shopId: String, withStatus orderStatus: Int, completion: @escaping ([OrderREST]?) -> Void)
    func putOrderHistoryItem(for historyItem: OrderHistoryREST, completion: @escaping (Bool) -> Void)
}
