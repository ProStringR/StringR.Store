//
//  ShopDAOFirebase.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 01/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class ShopDAOFirebase: ShopDAOProtocol {

    let dataControl = ControlReg.getDataController

    func getShop(by id: String) -> ShopDTO? {
        do {
            let shop = try dataControl.getData(returnType: ShopDTO.self, url: "\(Firebase.shop)/\(id)")
            return shop
        } catch {
            return nil
        }
    }

    func postShop(shop: ShopDTO?) throws {
        guard let shopDTO = shop else { throw Exception.nilPoint }
        try dataControl.postData(object: shopDTO, url: Firebase.shop)
    }

}
