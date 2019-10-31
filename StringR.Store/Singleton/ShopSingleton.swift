//
//  ShopSingleton.swift
//  StringR.Store
//
//  Created by Jaafar on 18/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class ShopSingleton {

    let shopController = ControlReg.getShopController

    static let shared = ShopSingleton()

    var shop: Shop?

    private init() { }

    func getShop(completion: @escaping (Shop?) -> Void) {
        if let shop = self.shop {
            completion(shop)
            return
        }

        shopController.getShop(basedOn: Utility.readStringFromSharedPref(Constant.shopId)) { (shop) in
            if let shop = shop {
                self.shop = shop
                completion(shop)
            }
        }
    }

    func refreshAndGetShop(completion: @escaping (Shop?) -> Void) {
        shopController.getShop(basedOn: Utility.readStringFromSharedPref(Constant.shopId)) { (shop) in
            if let shop = shop {
                self.shop = shop
                completion(shop)
            }
        }
    }
}
