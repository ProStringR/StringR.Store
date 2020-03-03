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

    var shop: ShopREST?

    var shopId: String
    var teamId: String

    private init() {
        self.shopId = Utility.readStringFromSharedPref(Constant.shopId)
        self.teamId = Utility.readStringFromSharedPref(Constant.teamId)
        print("Initializing shop singleton with teamId", self.teamId, "and shop", self.shopId)
    }

    func fetchData() {
        if shop == nil {
            shopController.getShop(by: self.shopId, completion: { (shop) in
                if let shop = shop {
                    self.shop = shop
                }
            })
        }
    }

    func getShop(completion: @escaping (ShopREST?) -> Void) {
        if let shop = self.shop {
            completion(shop)
            return
        }

        shopController.getShop(by: self.shopId, completion: { (shop) in
            if let shop = shop {
                self.shop = shop
            }
        })

    }

    func refreshAndGetShop(completion: @escaping (ShopREST?) -> Void) {
        shopController.getShop(by: Utility.readStringFromSharedPref(Constant.shopId)) { (shop) in
            if let shop = shop {
                self.shop = shop
                completion(shop)
            }
        }
    }
}
