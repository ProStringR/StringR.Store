//
//  Racket.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

struct Racket {

    var racketId: String
    var brand: String
    var modelName: String
    var weight: Int
    var main: Int
    var cross: Int

    enum RacketType: String {
        case TENNIS = "Tennis"
        case BADMINTON = "Badminton"
        case SQUASH = "Squash"
    }
}
