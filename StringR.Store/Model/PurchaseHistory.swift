//
//  PurchaseHistory.swift
//  StringR.Store
//
//  Created by Jaafar on 20/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class PurchaseHistory: Codable {
    var date: Int64
    var length: Double
    var price: Double

    init(date: Int64, length: Double, price: Double) {
        self.date = date
        self.length = length
        self.price = price
    }

    init?(date: String?, length: String?, price: String?) {
        guard let date = date, let length = length, let price = price else { return nil }

        if date.isEmpty || length.isEmpty || price.isEmpty { return nil }

        if let date = Int64(date), let length = Double(length), let price = Double(price) {
            self.date = date
            self.length = length
            self.price = price
        } else {
            return nil
        }
    }
}
