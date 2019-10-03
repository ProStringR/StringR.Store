//
//  StringType.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

enum StringType: String, Codable {
    case POLYESTER = "Polyester"
    case NATURALGUT = "Natural Gut"
    case SYNTHETICGUT = "Synthetic Gut"
    case MULTIFILAMENT = "Multifilament"
    case HYBRID = "Hybrid"
}

extension StringType {
    static var allValues: [StringType] {
        var allValues: [StringType] = []
        switch StringType.POLYESTER {
        case .POLYESTER: allValues.append(.POLYESTER); fallthrough
        case .NATURALGUT: allValues.append(.NATURALGUT); fallthrough
        case .SYNTHETICGUT: allValues.append(.SYNTHETICGUT); fallthrough
        case .MULTIFILAMENT: allValues.append(.MULTIFILAMENT); fallthrough
        case .HYBRID: allValues.append(.HYBRID)
        }
        return allValues
    }
}
