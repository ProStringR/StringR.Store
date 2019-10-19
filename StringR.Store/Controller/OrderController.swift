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

    func getOrder(by id: String, completion: @escaping (Order?) -> Void) {
        orderDAO.getOrder(by: id) { (result) in
            completion(result)
        }
    }

//    func getOrder(by id: String, completion: @escaping (Order?) -> Void) {
//        orderDAO.getOrder(by: id) { (result) in
//            let order = self.dataControl.createObject(fromObject: result, toObject: Order.self)
//
//            if let order = order {
//                self.teamControl.getStringer(basedOn: order.stringerId) { (stringer) in
//                    order.stringer = stringer
//                    completion(order)
//                }
//            } else {
//                completion(nil)
//            }
//        }
//    }

    func getRecievedOrders(shop: Shop, completion: @escaping ([Order]?) -> Void) {
        if let orderIds = shop.orderIds {
            orderDAO.getOrdersFiltered(orderIds: orderIds, status: .RECIEVED) { (result) in
                completion(result)
            }
        }
    }

    func getDoneOrders(shop: Shop, completion: @escaping ([Order]?) -> Void) {
        if let orderIds = shop.orderIds {
            orderDAO.getOrdersFiltered(orderIds: orderIds, status: .DONE) { (result) in
                completion(result)
            }
        }
    }

    func getDeliveredOrders(shop: Shop, completion: @escaping ([Order]?) -> Void) {
        if let orderIds = shop.orderIds {
            orderDAO.getOrdersFiltered(orderIds: orderIds, status: .DELIVERED) { (result) in
                completion(result)
            }
        }
    }

    func getCompletedOrders(shop: Shop, completion: @escaping ([Order]?) -> Void) {
        if let orderIds = shop.orderIds {
            orderDAO.getOrdersFiltered(orderIds: orderIds, status: .COMPLETE) { (result) in
                completion(result)
            }
        }
    }

    func putOrder(order: Order?, completion: @escaping (Bool) -> Void) {
        guard let order = order else { completion(false); return }
        let orderDTO = dataControl.createObject(fromObject: order, toObject: OrderDTO.self)

        orderDAO.putOrder(order: orderDTO) { (succes) in
            completion(succes)
        }
    }
}
