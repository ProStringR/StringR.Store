//
//  RacketString.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

struct RacketString {

    var stringId: String
    var stringType: StringType
    var length: Double
    var buyPrice: Double
    var pricePerRacket: Double
    var thickness: Double
    var color: StringColor
    var stringPurpose: Racket.RacketType

    enum StringType: String {
        case POLYESTER = "Polyester"
        case NATURALGUT = "Natural Gut"
        case SYNTHETICGUT = "Synthetic Gut"
        case MULTIFILAMENT = "Multifilament"
        case HYBRID = "Hybrid"
    }

    enum StringColor: String {
        case BLACK = "Black"
        case BLUE = "Blue"
        case GOLD = "Gold"
        case GREEN = "Green"
        case NATURAL = "Natural"
        case ORANGE = "Orange"
        case PINK = "Pink"
        case PURPLE = "Puple"
        case RED = "Red"
        case SILVER = "Silver"
        case TEAL = "Teal"
        case WHITE = "White"
        case YELLOW = "Yellow"
    }
}
