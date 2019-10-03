//
//  CompanyDTO.swift
//  StringR.Store
//
//  Created by Jaafar on 01/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

struct CompanyDTO: Codable {

    var companyId: String?
    var shopId: [String]?
    var name: String?
    var email: String?
    var phoneNumber: String?
}
