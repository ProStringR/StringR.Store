//
//  LoginResponse.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 02/12/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

struct LoginResponse: Codable {

    var token: String
    var id: Int
    var reponseMessage: String?
    var teamId: Int
}
