//
//  Economy.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class Economy: Codable {

    var tennisStrung: Int
    var badmintonStrung: Int
    var squashStrung: Int
    var revenue: Double
    var purchase: Double
    var profit: Double
    var unpaid: Double
    var expenses: Double

    init(tennisStrung: Int, badmintonStrung: Int, squashStrung: Int, revenue: Double, purchase: Double, profit: Double, unpaid: Double, expenses: Double) {
        self.tennisStrung = tennisStrung
        self.badmintonStrung = badmintonStrung
        self.squashStrung = squashStrung
        self.revenue = revenue
        self.purchase = purchase
        self.profit = profit
        self.unpaid = unpaid
        self.expenses = expenses
    }
}
