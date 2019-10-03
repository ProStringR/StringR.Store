//
//  RacketDTO.swift
//  StringR.Store
//
//  Created by Jaafar on 01/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

struct RacketDTO: Codable {

    var racketId: String?
    var brand: RacketBrand?
    var modelName: String?
    var weight: Int?
    var main: Int?
    var cross: Int?
}
