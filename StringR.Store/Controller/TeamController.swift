//
//  TeamController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 30/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class TeamController {

    let teamDAO: TeamDAOProtocol = ControlReg.getTeamDAO

    func postStringer(stringer: Stringer) throws {
        try teamDAO.postStringer(stringer: stringer)
    }
}
