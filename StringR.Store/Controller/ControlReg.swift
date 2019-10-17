//
//  ControlReg.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 30/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class ControlReg {

    // DAO
    static let getOrderDAO = OrderDAOFirebase()
    static let getTeamDAO = TeamDAOFirebase()
    static let getShopDAO = ShopDAOFirebase()
    static let getStorageDAO = StorageDAOFirebase()

    // Control
    static let getDataController = DataController()
    static let getOrderController = OrderController()
    static let getTeamController = TeamController()
    static let getShopController = ShopController()
    static let getStorageController = StorageController()
}
