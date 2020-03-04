//
//  ShopDaoSql.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 03/03/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class ShopDaoSql: ShopDAOProtocol {
    let dataControl = ControlReg.getDataController

    func getShop(by id: String, completion: @escaping (ShopREST?) -> Void) {
        dataControl.getDataREST(returnType: ShopREST.self, url: "\(Constant.shops)/\(id)") { (shop) in
            completion(shop)
        }
    }
}
