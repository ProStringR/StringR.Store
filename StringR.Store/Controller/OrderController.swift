//
//  OrderController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 19/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class OrderController {

    let dataControl = ControlReg.getDataController
    let teamControl = ControlReg.getTeamController
    let orderDAO: OrderDAOProtocol = ControlReg.getOrderDAO

    func getAllOrders(for shop: Shop, completion: @escaping ([Order]?) -> Void) {
        orderDAO.getAllOrders(for: shop) { (orders) in
            completion(orders)
        }
    }

    func getOrder(by id: String, completion: @escaping (Order?) -> Void) {
        orderDAO.getOrder(by: id) { (result) in
            completion(result)
        }
    }

    func getRecievedOrders(orderIds: [String]?, completion: @escaping ([Order]?) -> Void) {
        getOrdersFiltered(orderIds: orderIds, status: .RECEIVED) { (result) in
            completion(result)
        }
    }

    func getDoneOrders(orderIds: [String]?, completion: @escaping ([Order]?) -> Void) {
        getOrdersFiltered(orderIds: orderIds, status: .DONE) { (result) in
            completion(result)
        }
    }

    func getDeliveredOrders(orderIds: [String]?, completion: @escaping ([Order]?) -> Void) {
        getOrdersFiltered(orderIds: orderIds, status: .DELIVERED) { (result) in
            completion(result)
        }
    }

    func getCompletedOrders(orderIds: [String]?, completion: @escaping ([Order]?) -> Void) {
        getOrdersFiltered(orderIds: orderIds, status: .COMPLETE) { (result) in
            completion(result)
        }
    }

    func putOrder(order: Order?, completion: @escaping (Bool) -> Void) {
        guard let order = order else { completion(false); return }
        let orderDTO = dataControl.createObject(fromObject: order, toObject: OrderDTO.self)

        orderDAO.putOrder(order: orderDTO) { (succes) in
            completion(succes)
        }
    }

    private func getOrdersFiltered(orderIds: [String]?, status: OrderStatus, completion: @escaping ([Order]?) -> Void) {
        if let orderIds = orderIds {
            orderDAO.getOrdersFiltered(orderIds: orderIds, status: status) { (result) in
                completion(result)
            }
        } else {
            completion(nil)
        }
    }
}
