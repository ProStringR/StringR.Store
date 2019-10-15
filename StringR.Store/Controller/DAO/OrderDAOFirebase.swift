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

    func postOrder(order: OrderDTO) throws {
        do {
            try dataControl.postData(object: order, url: Firebase.order)
        } catch {
            throw error
        }
    }

    func putOrder(order: OrderDTO?, completion: @escaping (Bool) -> Void) {
        guard let order = order, let id = order.orderId else { completion(false); return }
        dataControl.putData(objectToUpdate: order, objectId: id, url: Firebase.order) { (succes) in
            completion(succes)
        }
    }
}
