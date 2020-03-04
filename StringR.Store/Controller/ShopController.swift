//
//  ShopController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 01/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class ShopController {

    let dataControl = ControlReg.getDataController
    let shopDAO: ShopDAOProtocol = ControlReg.getShopDAO

    func getShop(by shopId: String, completion: @escaping (ShopREST?) -> Void) {
        shopDAO.getShop(by: shopId) { (shop) in
            completion(shop)
        }
    }
}
