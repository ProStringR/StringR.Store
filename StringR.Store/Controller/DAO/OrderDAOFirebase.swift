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

    func getAllOrders(for shop: ShopFb, completion: @escaping ([OrderFb]?) -> Void) {
        if let orderIds = shop.orderIds {
            var listOfOrders: [OrderFb] = []
            var attempts = 0

            for orderId in orderIds {
                getOrder(by: orderId) { (order) in
                    attempts += 1
                    if let order = order {
                        listOfOrders.append(order)
                    }

                    if attempts == orderIds.count {
                        completion(listOfOrders)
                    }
                }
            }
        } else {
            completion(nil)
        }
    }

    func getOrder(by id: String, completion: @escaping (OrderFb?) -> Void) {
        dataControl.getData(returnType: OrderDTOFb.self, url: "\(Firebase.order)/\(id)", completion: { (result) in
            let order = self.dataControl.createObject(fromObject: result, toObject: OrderFb.self)

            if let order = order {
                var attemps = 0
                // find customer
                self.customerDAO.getCustomer(by: order.customerId) { (customerDTO) in
                    attemps += 1
                    order.customer = self.dataControl.createObject(fromObject: customerDTO, toObject: CustomerFb.self)
                    if attemps == 5 {
                        completion(order)
                    }
                }
                // find stringer
                self.teamDAO.getStringer(basedOn: order.stringerId) { (stringerDTO) in
                    attemps += 1
                    order.stringer = self.dataControl.createObject(fromObject: stringerDTO, toObject: StringerFb.self)
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
                    order.shop = self.dataControl.createObject(fromObject: shopDTO, toObject: ShopFb.self)
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

    func getOrdersFiltered(orderIds: [String]?, status: OrderStatus, completion: @escaping ([OrderFb]?) -> Void) {
        var attempts = 0
        var list: [OrderFb] = []

        guard let orderIds = orderIds else { completion(list); return}

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

    func postOrder(order: OrderDTOFb) throws {
        do {
            try dataControl.postData(object: order, url: Firebase.order)
        } catch {
            throw error
        }
    }

    func putOrder(order: OrderDTOFb?, completion: @escaping (Bool) -> Void) {
        guard let order = order, let id = order.orderId else { completion(false); return }
        dataControl.putData(objectToUpdate: order, objectId: id, url: Firebase.order) { (succes) in
            completion(succes)
        }
    }
}
