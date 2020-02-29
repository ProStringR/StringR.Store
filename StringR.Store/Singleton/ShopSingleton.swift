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

    var shop: ShopFb?

    var shopId: String = "1"

    private init() {
        //self.shopId = Utility.readStringFromSharedPref(Constant.shopId)
    }

    func getShop(completion: @escaping (ShopFb?) -> Void) {
        if let shop = self.shop {
            completion(shop)
            return
        }

        shopController.getShop(basedOn: Utility.readStringFromSharedPref(Constant.shopId)) { (shopFb) in
            if let shopFb = shopFb {
                self.shop = shopFb
                completion(shopFb)
            }
        }

    }

    func refreshAndGetShop(completion: @escaping (ShopFb?) -> Void) {
        shopController.getShop(basedOn: Utility.readStringFromSharedPref(Constant.shopId)) { (shop) in
            if let shop = shop {
                self.shop = shop
                completion(shop)
            }
        }
    }
}
