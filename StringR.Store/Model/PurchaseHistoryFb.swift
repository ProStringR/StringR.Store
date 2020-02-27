//
//  PurchaseHistory.swift
//  StringR.Store
//
//  Created by Jaafar on 20/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class PurchaseHistoryFb: Codable {
    var date: Int64
    var length: Double
    var price: Double

    init(date: Int64, length: Double, price: Double) {
        self.date = date
        self.length = length
        self.price = price
    }

    init?(date: Int64, length: String?, price: String?) {
        guard let length = length, let price = price else { return nil }

        if length.isEmpty || price.isEmpty { return nil }

        if let length = Double(length), let price = Double(price) {
            self.date = date
            self.length = length
            self.price = price
        } else {
            return nil
        }
    }
}
