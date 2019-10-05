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

    func getShop(by id: String) -> Shop? {
        let dto = shopDAO.getShop(by: id)

        if let shopDTO = dto {
            return dataControl.createObject(fromObject: shopDTO, toObject: Shop.self)
        } else {
            return nil
        }
    }

    func postShop(shop: Shop) throws {
        let shopDTO = dataControl.createObject(fromObject: shop, toObject: ShopDTO.self)
        try shopDAO.postShop(shop: shopDTO)
    }
}
