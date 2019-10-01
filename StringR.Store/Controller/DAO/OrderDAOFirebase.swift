//
//  OrderDAO.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 19/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class OrderDAOFirebase: OrderDAOProtocol {

    let dataControl = ControlReg.getDataController

    func getActiveOrders() throws -> [OrderDTO] {
        do {
            var orders = [OrderDTO]()
            let data = try dataControl.getData(returnType: [String: OrderDTO].self, url: Firebase.order)

            for order in data {
                orders.append(order.value)
            }

            return orders
        } catch {
            throw error
        }
    }

    func postOrder(order: OrderDTO) throws {
        do {
            try dataControl.postData(object: order, url: Firebase.order)
        } catch {
            throw error
        }
    }
}
