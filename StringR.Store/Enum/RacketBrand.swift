//
//  RacketBrand.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

enum RacketBrand: String, Codable {
    case BABOLAT = "Babolat"
    case BLACKKNIGHT = "Black Knight"
    case CARLTON = "Carlton"
    case DUNLOP = "Dunlop"
    case EYE = "Eye"
    case FORZA = "Forza"
    case GAMMA = "Gamma"
    case GRAYS = "Grays"
    case HARROW = "Harrow"
    case HEAD = "Head"
    case KARAKAL = "Karakal"
    case LINING = "Li-Ning"
    case PRINCE = "Prince"
    case PROKENEX = "ProKennex"
    case RSL = "RSL"
    case SIGNUMPRO = "Signum Pro"
    case TACTIC = "Tactic"
    case TECNIFIBRE = "Tecnifibre"
    case VICTOR = "Victor"
    case VOLKL = "Volkl"
    case WILSON = "Wilson"
    case YONEX = "Yonex"
    case ZERV = "Zerv"
    case OTHER = "Other"
}

extension RacketBrand {
    static var allValues: [RacketBrand] {
        var allValues: [RacketBrand] = []
        switch RacketBrand.BABOLAT {
        case .BABOLAT: allValues.append(.BABOLAT); fallthrough
        case .BLACKKNIGHT: allValues.append(.BLACKKNIGHT); fallthrough
        case .CARLTON: allValues.append(.CARLTON); fallthrough
        case .DUNLOP: allValues.append(.DUNLOP); fallthrough
        case .EYE: allValues.append(.EYE); fallthrough
        case .FORZA: allValues.append(.FORZA); fallthrough
        case .GAMMA: allValues.append(.GAMMA); fallthrough
        case .GRAYS: allValues.append(.GRAYS); fallthrough
        case .HARROW: allValues.append(.HARROW); fallthrough
        case .HEAD: allValues.append(.HEAD); fallthrough
        case .KARAKAL: allValues.append(.KARAKAL); fallthrough
        case .LINING: allValues.append(.LINING); fallthrough
        case .PRINCE: allValues.append(.PRINCE); fallthrough
        case .PROKENEX: allValues.append(.PROKENEX); fallthrough
        case .RSL: allValues.append(.RSL); fallthrough
        case .SIGNUMPRO: allValues.append(.SIGNUMPRO); fallthrough
        case .TACTIC: allValues.append(.TACTIC); fallthrough
        case .TECNIFIBRE: allValues.append(.TECNIFIBRE); fallthrough
        case .VICTOR: allValues.append(.VICTOR); fallthrough
        case .VOLKL: allValues.append(.VOLKL); fallthrough
        case .WILSON: allValues.append(.WILSON); fallthrough
        case .YONEX: allValues.append(.YONEX); fallthrough
        case .ZERV: allValues.append(.ZERV); fallthrough
        case .OTHER: allValues.append(.OTHER)
        }
        return allValues
    }
}
