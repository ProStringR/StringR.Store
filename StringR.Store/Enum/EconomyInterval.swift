//
//  EconomyInterval.swift
//  StringR.Store
//
//  Created by Jaafar on 31/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

enum EconomyInterval: Int, Codable {
    case day = 0
    case week = 1
    case month = 2
    case year = 3
    case all = 4
}
