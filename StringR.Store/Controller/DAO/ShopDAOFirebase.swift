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

    func getShop(by id: String, completion: @escaping (ShopDTO?) -> Void) {
        dataControl.getData(returnType: ShopDTO.self, url: "\(Firebase.shop)/\(id)", completion: { (result) in
            completion(result)
        })
    }

    func postShop(shop: ShopDTO?) throws {
        guard let shopDTO = shop else { throw Exception.nilPoint }
        try dataControl.postData(object: shopDTO, url: Firebase.shop)
    }

    func putShop(shop: ShopDTO?, completion: @escaping (Bool) -> Void) {
        guard let shop = shop, let id = shop.shopId else { completion(false); return }
        dataControl.putData(objectToUpdate: shop, objectId: id, url: Firebase.shop) { (succes) in
            completion(succes)
        }
    }

}
