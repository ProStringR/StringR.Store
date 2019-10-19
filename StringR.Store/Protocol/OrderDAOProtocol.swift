//
//  OrderDAOProtocol.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 19/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol OrderDAOProtocol {
    func getOrder(by id: String, completion: @escaping (Order?) -> Void)
    func getOrdersFiltered(orderIds: [String], status: OrderStatus, completion: @escaping ([Order]?) -> Void)
    func postOrder(order: OrderDTO) throws
    func putOrder(order: OrderDTO?, completion: @escaping (Bool) -> Void)
}
