//
//  ShopDAOProtocol.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 01/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol ShopDAOProtocol {
    func getShop(by id: String, completion: @escaping (ShopDTOFb?) -> Void)
    func postShop(shop: ShopDTOFb?) throws
    func putShop(shop: ShopDTOFb?, completion: @escaping (Bool) -> Void)
    func getShop(by id: String, completion: @escaping (ShopREST?) -> Void)
}
