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
            completion(self.dataControl.createObject(fromObject: result, toObject: Order.self))
        }
    }

    func getRecievedOrders(shop: Shop, completion: @escaping ([Order]?) -> Void) {
        if let orderIds = shop.orderIds {
            orderDAO.getOrdersFiltered(orderIds: orderIds, status: .RECIEVED) { (result) in
                if let result = result {
                    var listToReturn: [Order] = []
                    for orderDTO in result {
                        let order = self.dataControl.createObject(fromObject: orderDTO, toObject: Order.self)
                        if let order = order {
                            listToReturn.append(order)
                        }
                    }
                    completion(listToReturn)
                }
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
