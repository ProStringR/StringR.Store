//
//  CustomerDTO.swift
//  StringR.Store
//
//  Created by Jaafar on 03/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

struct CustomerDTO: Codable {

    var userId: String?
    var name: String?
    var birthday: Int64?
    var email: String?
    var phoneNumber: String?
    var orderIds: [String]?
    var preferedStringType: StringType?
    var preferedTensionVertical: Double?
    var prederedTensionHorizontal: Double?
}
