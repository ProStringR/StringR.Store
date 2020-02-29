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
    var stringThickness: Double?
    var stringPurpose: String?
    var stringColor: String?

    init?(stringId: Int?, price: String?, lengthInStock: String?, stringModel: String?, stringType: String?, stringBrand: String?, thickness: String?, purpose: String?, color: String?) {

        guard let lengthInStock = lengthInStock, let price = price, let thickness = thickness else { return nil}

        self.stringId = stringId
        self.price = Double(price)
        self.lengthInStock = Double(lengthInStock)
        self.stringModel = stringModel
        self.stringType = stringType
        self.stringBrand = stringBrand
        self.stringThickness = Double(thickness)
        self.stringPurpose = purpose
        self.stringColor = color
     }

    func getDescription() -> String {
        if let brand = self.stringBrand, let model = self.stringModel, let thick = self.stringThickness {
            return "\(brand) | \(model) | \(thick)"
        } else {
            return "Could not fetch data"
        }
    }
}
