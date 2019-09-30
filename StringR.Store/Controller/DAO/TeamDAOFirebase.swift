//
//  TeamDAOFirebase.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 30/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class TeamDAOFirebase: TeamDAOProtocol {

    func postStringer(stringer: Stringer) throws {
        try DataController.postData(object: stringer, url: Firebase.stringer)
    }

}
