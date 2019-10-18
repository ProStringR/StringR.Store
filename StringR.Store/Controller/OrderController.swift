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

    func putOrder(order: Order?, completion: @escaping (Bool) -> Void) {
        guard let order = order else { completion(false); return }
        let orderDTO = dataControl.createObject(fromObject: order, toObject: OrderDTO.self)

        orderDAO.putOrder(order: orderDTO) { (succes) in
            completion(succes)
        }
    }
}
