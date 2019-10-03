//
//  Team.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 13/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class Team: Codable {

    var stringerIds: [String]
    
    init(stringerIds: [String]) {
        self.stringerIds = stringerIds
    }
}
