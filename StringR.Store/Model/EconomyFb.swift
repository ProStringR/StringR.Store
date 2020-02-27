//
//  Economy.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class EconomyFb: Codable {

    var tennisStrung: Int
    var badmintonStrung: Int
    var squashStrung: Int
    var revenue: Double
    var stringExpense: Double
    var profit: Double
    var unpaid: Double
    var expenses: Double
    var numberOfPendingOrders: Int

    var totalStrung: Int {
        return tennisStrung + badmintonStrung + squashStrung
    }

    init(tennisStrung: Int, badmintonStrung: Int, squashStrung: Int, revenue: Double, stringExpense: Double, profit: Double, unpaid: Double, expenses: Double, pendingOrders: Int) {
        self.tennisStrung = tennisStrung
        self.badmintonStrung = badmintonStrung
        self.squashStrung = squashStrung
        self.revenue = revenue
        self.stringExpense = stringExpense
        self.profit = profit
        self.unpaid = unpaid
        self.expenses = expenses
        self.numberOfPendingOrders = pendingOrders
    }
}
