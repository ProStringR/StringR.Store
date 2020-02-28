//
//  Constant.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 16/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class Constant {

    //REST API
    static let baseUrl = "https://prostringr.com/api/v1"
    static let authenticationUrl = "\(baseUrl)/authentication"
    static let staticData = "/staticdata"
    static let allColorsStaticData = "\(baseUrl)\(staticData)/all-colors"
    static let allPurposes = "\(baseUrl)\(staticData)/all-purposes"
    static let allRacketBrands = "\(baseUrl)\(staticData)/all-racket-brands"
    static let allStringBrands = "\(baseUrl)\(staticData)/all-string-brands"
    static let allStringTypes = "\(baseUrl)\(staticData)/all-string-types"

    // Numbers
    static let noOffset = CGFloat(0)
    static let standardOffset = CGFloat(8)
    static let bigOffset = CGFloat(16)
    static let hugeOffset = CGFloat(32)
    static let gigantOffset = CGFloat(64)
    static let headerSize = CGFloat(24)
    static let smallHeaderSize = CGFloat(20)
    static let tableViewRowHeight = CGFloat(60)
    static let popupTopBottom = CGFloat(160)
    static let popupLeadingTrailing = CGFloat(75)
    static let standardCornerRadius = CGFloat(10)
    static let smallCornerRadius = CGFloat(5)
    static let standardButtonHeight = CGFloat(50)

    // Strings
    static let emptyString = ""
    static let shopId = "shopId"
    static let token = "token"

    static let stringLengthPerRacket = 10
}
