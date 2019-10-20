//
//  RacketString.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class RacketString: Codable {

    var stringId: String
    var brand: StringBrand
    var modelName: String
    var stringType: StringType
    var length: Double
    var buyDate: Int64
    var buyPrice: Double
    var pricePerRacket: Double
    var thickness: Double
    var color: StringColor
    var stringPurpose: RacketType
    var purchaseHistory: [PurchaseHistory]?
    var racketRemaining: Int {
        let stringPerRacket = Constant.stringLengthPerRacket
        let lengthRemaining = Double(self.length) / Double(stringPerRacket)

        return Int(lengthRemaining / Double(stringPerRacket))
    }

    init(stringId: String, brand: StringBrand, modelName: String, stringType: StringType, length: Double, buyDate: Int64, buyPrice: Double, pricePerRacket: Double, thickness: Double, color: StringColor, stringPurpose: RacketType, setUsed: Double) {
        self.stringId = stringId
        self.brand = brand
        self.modelName = modelName
        self.stringType = stringType
        self.length = length
        self.buyDate = buyDate
        self.buyPrice = buyPrice
        self.pricePerRacket = pricePerRacket
        self.thickness = thickness
        self.color = color
        self.stringPurpose = stringPurpose
    }

    init?(stringId: String?, brand: String?, modelName: String?, stringType: String?, length: String?, buyDate: String?, buyPrice: String?, pricePerRacket: String?, thickness: String?, color: String?, stringPurpose: String?) {

        if let stringId = stringId, let brand = brand, let modelName = modelName, let stringType = stringType, let length = length, let buyDate = buyDate, let buyPrice = buyPrice,
            let pricePerRacket = pricePerRacket, let thickness = thickness, let color = color, let stringPurpose = stringPurpose {

            if brand.isEmpty || modelName.isEmpty || stringType.isEmpty || length.isEmpty || buyDate.isEmpty || buyPrice.isEmpty || pricePerRacket.isEmpty || thickness.isEmpty || color.isEmpty || stringPurpose.isEmpty {
                return nil
            }

            self.stringId = stringId
            self.brand = StringBrand(rawValue: brand) ?? StringBrand.DEFAULT
            self.modelName = modelName
            self.stringType = StringType(rawValue: stringType) ?? StringType.DEAULT
            self.length = Double(length) ?? 0
            self.buyDate = Int64(buyDate) ?? 0
            self.buyPrice = Double(buyPrice) ?? 0
            self.pricePerRacket = Double(pricePerRacket) ?? 0
            self.thickness = Double(thickness) ?? 0
            self.color = StringColor(rawValue: color) ?? StringColor.DEFAULT
            self.stringPurpose = RacketType(rawValue: stringPurpose) ?? RacketType.TENNIS

            self.purchaseHistory = []
            let historyItem = PurchaseHistory.init(date: self.buyDate, length: self.length, price: self.buyPrice)

            if let historyItem = historyItem {
                self.purchaseHistory?.append(historyItem)
            }
        } else {
            return nil
        }
    }

    func getDescription() -> String {
        return "\(self.brand.rawValue) | \(self.modelName) | \(self.thickness)"
    }

    func getImageIndication() -> UIImage {
        switch self.stringPurpose {
        case .TENNIS:
            return #imageLiteral(resourceName: "tennisball")
        case .BADMINTON:
            return #imageLiteral(resourceName: "shuttlecock")
        case .SQUASH:
            return #imageLiteral(resourceName: "squashball")
        }
    }
}
