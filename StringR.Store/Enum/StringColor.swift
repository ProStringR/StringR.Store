//
//  StringColor.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

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

extension StringColor {
    static var allValues: [StringColor] {
        var allValues: [StringColor] = []
        switch StringColor.BLACK {
        case .BLACK: allValues.append(.BLACK); fallthrough
        case .BLUE: allValues.append(.BLUE); fallthrough
        case .GOLD: allValues.append(.GOLD); fallthrough
        case .GREEN: allValues.append(.GREEN); fallthrough
        case .NATURAL: allValues.append(.NATURAL); fallthrough
        case .ORANGE: allValues.append(.ORANGE); fallthrough
        case .PINK: allValues.append(.PINK); fallthrough
        case .PURPLE: allValues.append(.PURPLE); fallthrough
        case .RED: allValues.append(.RED); fallthrough
        case .SILVER: allValues.append(.SILVER); fallthrough
        case .TEAL: allValues.append(.TEAL); fallthrough
        case .WHITE: allValues.append(.WHITE); fallthrough
        case .YELLOW: allValues.append(.YELLOW)
        }
        return allValues
    }
}
