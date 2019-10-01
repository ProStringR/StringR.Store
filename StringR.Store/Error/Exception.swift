//
//  NetworkError.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 19/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

enum Exception: Error {
    case url
    case statusCode
    case error
    case nilPoint
}
