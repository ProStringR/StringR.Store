//
//  RacketType.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

enum RacketType: String {
    case TENNIS = "Tennis"
    case BADMINTON = "Badminton"
    case SQUASH = "Squash"
}

extension RacketType {
    static var allValues: [RacketType] {
        var allValues: [RacketType] = []
        switch RacketType.TENNIS {
        case .TENNIS: allValues.append(.TENNIS); fallthrough
        case .BADMINTON: allValues.append(.BADMINTON); fallthrough
        case .SQUASH: allValues.append(.SQUASH)
        }
        return allValues
    }
}
