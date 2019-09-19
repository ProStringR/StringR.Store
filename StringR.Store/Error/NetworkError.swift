//
//  NetworkError.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 19/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case url
    case statusCode
    case error
}
