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
    let customerDAO: CustomerDAOProtocol = ControlReg.getCustomerDAO
    let teamDAO: TeamDAOProtocol = ControlReg.getTeamDAO
    let shopDAO: ShopDAOProtocol = ControlReg.getShopDAO
    let storageDAO: StorageDAOProtocol = ControlReg.getStorageDAO
    let racketDAO: RacketDAOProtocol = ControlReg.getRacketDAO

    func getOrder(by id: String, completion: @escaping (Order?) -> Void) {
        dataControl.getData(returnType: OrderDTO.self, url: "\(Firebase.order)/\(id)", completion: { (result) in
            let order = self.dataControl.createObject(fromObject: result, toObject: Order.self)

            if let order = order {
                var attemps = 0
                // find customer
                self.customerDAO.getCustomer(by: order.customerId) { (customerDTO) in
                    attemps += 1
                    order.customer = self.dataControl.createObject(fromObject: customerDTO, toObject: Customer.self)
                    if attemps == 5 {
                        completion(order)
                    }
                }
                // find stringer
                self.teamDAO.getStringer(basedOn: order.stringerId) { (stringerDTO) in
                    attemps += 1
                    order.stringer = self.dataControl.createObject(fromObject: stringerDTO, toObject: Stringer.self)
                    if attemps == 5 {
                        completion(order)
                    }
                }

                // find racketString
                self.storageDAO.getRacketString(by: order.stringId, storageId: order.shopId) { (racketString) in
                    attemps += 1
                    order.racketString = racketString
                    if attemps == 5 {
                        completion(order)
                    }
                }
                // find shop
                self.shopDAO.getShop(by: order.shopId) { (shopDTO) in
                    attemps += 1
                    order.shop = self.dataControl.createObject(fromObject: shopDTO, toObject: Shop.self)
                    if attemps == 5 {
                        completion(order)
                    }
                }

                // find racket
                self.racketDAO.getRacket(racketId: order.racketId) { (racket) in
                    attemps += 1
                    order.racket = racket
                    if attemps == 5 {
                        completion(order)
                    }
                }
            }
        })
    }

    func getOrdersFiltered(orderIds: [String], status: OrderStatus, completion: @escaping ([Order]?) -> Void) {
        var attempts = 0
        var list: [Order] = []

        for id in orderIds {
            self.getOrder(by: id) { (result) in
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
