//
//  OrderDAOProtocol.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 19/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol OrderDAOProtocol {
    func getAllOrders(for shop: ShopFb, completion: @escaping ([OrderFb]?) -> Void)
    func getOrder(by id: String, completion: @escaping (OrderFb?) -> Void)
    func getOrdersFiltered(orderIds: [String]?, status: OrderStatus, completion: @escaping ([OrderFb]?) -> Void)
    func postOrder(order: OrderDTOFb) throws
    func putOrder(order: OrderDTOFb?, completion: @escaping (Bool) -> Void)
}
