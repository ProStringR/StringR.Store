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

    func getShop(basedOn id: String, completion: @escaping (ShopFb?) -> Void) {

        shopDAO.getShop(by: id) { (dto) in
            if let shopDTO = dto {
                let shop = self.dataControl.createObject(fromObject: shopDTO, toObject: ShopFb.self)
                completion(shop)
            } else {
                completion(nil)
            }
        }
    }

    func postShop(shop: ShopFb) throws {
        let shopDTO = dataControl.createObject(fromObject: shop, toObject: ShopDTOFb.self)
        try shopDAO.postShop(shop: shopDTO)
    }

    func putShop(shop: ShopFb, completion: @escaping (Bool) -> Void) {
        let shopDTO = dataControl.createObject(fromObject: shop, toObject: ShopDTOFb.self)
        shopDAO.putShop(shop: shopDTO) { (succes) in
            completion(succes)
        }
    }
}
