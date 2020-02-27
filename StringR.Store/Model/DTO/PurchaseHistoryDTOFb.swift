//
//  PurchaseHistoryDTO.swift
//  StringR.Store
//
//  Created by Jaafar on 20/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

struct PurchaseHistoryDTOFb: Codable {
    var date: Int64?
    var length: Double?
    var price: Double?
}
