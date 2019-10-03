//
//  StringBrand.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

enum StringBrand: String, Codable {
    case ASHAWAY = "Ashaway"
    case BABOLAT = "Babolat"
    case DUNLOP = "Dunlop"
    case GAMMA = "Gamma"
    case HEAD = "Head"
    case KIRSCHBAUM = "Kirschbaum"
    case LUXILON = "Luxilon"
    case PRINCE = "Prince"
    case SIGNUMPRO = "Signum Pro"
    case SOLINCO = "Solinco"
    case TECNIFIBRE = "Tecnifibre"
    case VOLKL = "Volkl"
    case WILSON = "Wilson"
    case YONEX = "Yonex"
}

extension StringBrand {
    static var allValues: [StringBrand] {
        var allValues: [StringBrand] = []
        switch StringBrand.ASHAWAY {
        case .ASHAWAY: allValues.append(.ASHAWAY); fallthrough
        case .BABOLAT: allValues.append(.BABOLAT); fallthrough
        case .DUNLOP: allValues.append(.DUNLOP); fallthrough
        case .HEAD: allValues.append(.HEAD); fallthrough
        case .GAMMA: allValues.append(.GAMMA); fallthrough
        case .KIRSCHBAUM: allValues.append(.KIRSCHBAUM); fallthrough
        case .LUXILON: allValues.append(.LUXILON); fallthrough
        case .PRINCE: allValues.append(.PRINCE); fallthrough
        case .SIGNUMPRO: allValues.append(.SIGNUMPRO); fallthrough
        case .SOLINCO: allValues.append(.SOLINCO); fallthrough
        case .TECNIFIBRE: allValues.append(.TECNIFIBRE); fallthrough
        case .VOLKL: allValues.append(.VOLKL); fallthrough
        case .WILSON: allValues.append(.WILSON); fallthrough
        case .YONEX: allValues.append(.YONEX)
        }
        return allValues
    }
}
