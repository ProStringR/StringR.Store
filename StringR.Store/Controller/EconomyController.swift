//
//  EconomyController.swift
//  StringR.Store
//
//  Created by Jaafar on 31/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class EconomyController {
//    func getListOfOrders(basedOn interval: EconomyInterval, with orders: [OrderFb]?) -> [OrderFb] {
//        var listOfOrders: [OrderFb] = []
//
//        guard let orders = orders else { return listOfOrders }
//
//        for order in orders {
//            if interval == .all {
//                listOfOrders = orders
//            } else if interval == .year {
//                if Date().isInSameYear(date: Date(milliseconds: order.deliveryDate)) {
//                    listOfOrders.append(order)
//                }
//            } else if interval == .month {
//                if Date().isInSameMonth(date: Date(milliseconds: order.deliveryDate)) {
//                    listOfOrders.append(order)
//                }
//            } else if interval == .week {
//                if Date().isInSameWeek(date: Date(milliseconds: order.deliveryDate)) {
//                    listOfOrders.append(order)
//                }
//            } else if interval == .day {
//                if Date().isInSameDay(date: Date(milliseconds: order.deliveryDate)) {
//                    listOfOrders.append(order)
//                }
//            }
//        }
//
//        return listOfOrders
//    }
//
//    func calculateEconomy(basedOn orders: [OrderFb]) -> EconomyFb {
//        var tennisStrung: Int = 0
//        var badmintonStrung: Int = 0
//        var squashStrung: Int = 0
//        var revenue: Double = 0
//        var stringExpence: Double = 0
//        var profit: Double = 0
//        var unpaid: Double = 0
//        var expenses: Double = 0
//        var numberOfPendingOrders: Int = 0
//
//        for order in orders {
//            switch order.racketType {
//            case .TENNIS:
//                tennisStrung += 1
//            case .BADMINTON:
//                badmintonStrung += 1
//            case .SQUASH:
//                squashStrung += 1
//            }
//
//            if let expence = order.racketString?.expencePerRacket {
//                stringExpence += expence
//            }
//
//            if order.orderStatus == .RECEIVED {
//                numberOfPendingOrders += 1
//            }
//
//            if order.orderStatus != .RECEIVED && !order.paid {
//                unpaid += order.price
//            }
//
//            if order.paid {
//                revenue += order.price
//            }
//
//            // Something we just do for now
//            expenses = 1
//
//            profit = revenue - expenses - stringExpence
//        }
//
//        return EconomyFb.init(tennisStrung: tennisStrung, badmintonStrung: badmintonStrung, squashStrung: squashStrung, revenue: revenue, stringExpense: stringExpence, profit: profit, unpaid: unpaid, expenses: expenses, pendingOrders: numberOfPendingOrders)
//    }
}
