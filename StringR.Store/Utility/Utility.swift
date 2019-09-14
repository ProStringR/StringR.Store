//
//  Utility.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 14/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class Utility {

    static func getString(forKey key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }

}
