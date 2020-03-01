//
//  PurchaseHistoryREST.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 01/03/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class PurchaseHistoryREST: Codable {
    var id: Int?
    var racketStringId: Int?
    var transactionDate: Int64
    var lengthAdded: Double
    var price: Double

    init(date: Int64, length: Double, price: Double) {
        self.transactionDate = date
        self.lengthAdded = length
        self.price = price
    }

    init?(date: Int64, length: String?, price: String?) {
        guard let length = length, let price = price else { return nil }

        if length.isEmpty || price.isEmpty { return nil }

        if let length = Double(length), let price = Double(price) {
            self.transactionDate = date
            self.lengthAdded = length
            self.price = price
        } else {
            return nil
        }
    }
}
