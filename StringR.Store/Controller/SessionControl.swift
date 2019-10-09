//
//  Session.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 01/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class SessionControl {

    let shopControl = ControlReg.getShopController

    static func getShop() -> Shop {
        if let shop = shopControl.getShop(by: "shopMJ")
    }

}
