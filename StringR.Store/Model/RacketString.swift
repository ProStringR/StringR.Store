//
//  RacketString.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

struct RacketString {

    //var stringId: String
    var brand: StringBrand
    var modelName: String
    //var stringType: StringType
    //var length: Double
    //var buyDate: Int64
    //var buyPrice: Double
    //var pricePerRacket: Double
    var thickness: Double
    //var color: StringColor
    var stringPurpose: RacketType
    var setUsed: Double

    func getDescription() -> String {
        return "\(self.brand.rawValue) | \(self.modelName) | \(self.thickness)"
    }

//    func racketRemaining() -> Int {
//        let stringPerRacket = Constant.stringLengthPerRacket
//        let lengthRemaining = Double(self.length) - (Double(stringPerRacket) * self.setUsed)
//
//        return Int(lengthRemaining / Double(stringPerRacket))
//    }
}
