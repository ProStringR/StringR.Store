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

    func getOrder(by id: String, completion: @escaping (OrderDTO?) -> Void) {
        dataControl.getData(returnType: OrderDTO.self, url: "\(Firebase.order)/\(id)", completion: { (result) in
            completion(result)
        })
    }

    func getOrdersFiltered(orderIds: [String], status: OrderStatus, completion: @escaping ([OrderDTO]?) -> Void) {

        var attempts = 0
        var list: [OrderDTO] = []

        for id in orderIds {
            getOrder(by: id) { (result) in
                attempts += 1
                if let order = result, order.orderStatus == status {
                    list.append(order)
                }

                if attempts == orderIds.count {
                    completion(list)
                }
            }
        }
    }

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
