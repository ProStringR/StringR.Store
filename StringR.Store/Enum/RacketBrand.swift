//
//  RacketBrand.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

enum RacketBrand: String {
    case BABOLAT = "Babolat"
    case DUNLOP = "Dunlop"
    case GAMMA = "Gamma"
    case HEAD = "Head"
    case PRINCE = "Prince"
    case PROKENEX = "ProKennex"
    case SIGNUMPRO = "Signum Pro"
    case TECNIFIBRE = "Tecnifibre"
    case VOLKL = "Volkl"
    case WILSON = "Wilson"
    case YONEX = "Yonex"
}

extension RacketBrand {
    static var allValues: [RacketBrand] {
        var allValues: [RacketBrand] = []
        switch RacketBrand.BABOLAT {
        case .BABOLAT: allValues.append(.BABOLAT); fallthrough
        case .DUNLOP: allValues.append(.DUNLOP); fallthrough
        case .GAMMA: allValues.append(.GAMMA); fallthrough
        case .HEAD: allValues.append(.HEAD); fallthrough
        case .PRINCE: allValues.append(.PRINCE); fallthrough
        case .PROKENEX: allValues.append(.PROKENEX); fallthrough
        case .SIGNUMPRO: allValues.append(.SIGNUMPRO); fallthrough
        case .TECNIFIBRE: allValues.append(.TECNIFIBRE); fallthrough
        case .VOLKL: allValues.append(.VOLKL); fallthrough
        case .WILSON: allValues.append(.WILSON); fallthrough
        case .YONEX: allValues.append(.YONEX)
        }
        return allValues
    }
}
