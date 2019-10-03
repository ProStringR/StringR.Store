//
//  Racket.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class Racket: Codable {

    var racketId: String
    var brand: RacketBrand
    var modelName: String
    var weight: Int
    var main: Int
    var cross: Int

    init(racketId: String, brand: RacketBrand, modelName: String, weight: Int, main: Int, cross: Int) {
        self.racketId = racketId
        self.brand = brand
        self.modelName = modelName
        self.weight = weight
        self.main = main
        self.cross = cross
    }
}
