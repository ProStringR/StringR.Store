//
//  EconomyController.swift
//  StringR.Store
//
//  Created by Jaafar on 31/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class EconomyController {
    func updateEconomy(basedOn interval: Int, for economy: Economy, with orders: [Order]) {
        var tennisStrung: Int = 0
        var badmintonStrung: Int = 0
        var squashStrung: Int = 0
        var revenue: Double = 0
        var purchase: Double = 0
        var profit: Double = 0
        var unpaid: Double = 0
        var expenses: Double = 0

        for order in orders {
            if interval == EconomyInterval.day.rawValue {
                
            }
        }
    }
}
