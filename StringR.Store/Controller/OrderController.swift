//
//  OrderController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 19/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class OrderController {

    let dataControl = ControlReg.getDataController
    let teamControl = ControlReg.getTeamController
    let orderDAO: OrderDAOProtocol = ControlReg.getOrderDAO
}
