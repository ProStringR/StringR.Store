//
//  RacketStringREST.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 29/02/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class RacketStringREST: Codable {
    var stringId: Int?
    var price: Double?
    var lengthInStock: Double?
    var stringModel: String?
    var stringType: String?
    var stringBrand: String?
    var thickness: Double?
    var purpose: String?
    var color: String?

    init(stringId: Int?, price: Double?, lengthInStock: Double?, stringModel: String?, stringType: String?, stringBrand: String?, thickness: Double?, purpose: String?, color: String?) {
         self.stringId = stringId
         self.price = price
         self.lengthInStock = lengthInStock
         self.stringModel = stringModel
         self.stringType = stringType
         self.stringBrand = stringBrand
         self.thickness = thickness
         self.purpose = purpose
         self.color = color
     }
}
