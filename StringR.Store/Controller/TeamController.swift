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
    let dataControl = ControlReg.getDataController

    func getStringersForShop(teamId: String, completion: @escaping ([StringerREST]?) -> Void) {
        teamDAO.getTeamForShop(teamId: teamId) { (stringers) in
            completion(stringers)
        }
    }

    func postStringerToTeam(teamId: Int, with stringer: StringerDto, completion: @escaping (Bool) -> Void) {
        teamDAO.postStringerToTeam(teamId: teamId, with: stringer) { (success) in
            completion(success)
        }
    }
}
