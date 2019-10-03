//
//  CustomerDTO.swift
//  StringR.Store
//
//  Created by Jaafar on 03/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

struct CustomerDTO: Codable {

    var preferedStringType: StringType?
    var preferedTensionVertical: Double?
    var prederedTensionHorizontal: Double?
}
