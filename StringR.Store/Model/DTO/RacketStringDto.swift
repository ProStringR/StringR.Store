//
//  RacketStringDto.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 28/02/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class RacketStringDto: Codable {
    var shopId: String
    var brand: Int
    var model: String
    var stringType: Int
    var length: Double
    var pricePerRacket: Double
    var thickness: Double
    var color: Int
    var purpose: Int
    var datePlaced: Int64
    var price: Double

    init?(brand: Int?, name: String?, type: Int?, length: String?, pricePerRacket: String?, color: Int?, purpose: Int?, thickness: String?, date: Int64, price: String?) {
        guard let brand = brand, let name = name, let type = type, let length = length, let ppr = pricePerRacket, let color = color, let purpose = purpose, let thickness = thickness, let price = price else { return nil }

        if ShopSingleton.shared.shopId.elementsEqual("0") {
            return nil
        }

        self.shopId = ShopSingleton.shared.shopId
        self.brand = brand
        self.model = name
        self.stringType = type
        self.length = Double(length) ?? 0
        self.pricePerRacket = Double(ppr) ?? 0
        self.thickness = Double(thickness) ?? 0
        self.color = color
        self.purpose = purpose
        self.datePlaced = date
        self.price = Double(price) ?? 0
    }
}
