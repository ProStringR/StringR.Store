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

    func getStringer(basedOn stringerId: String) -> Stringer? {
        let dto = teamDAO.getStringer(basedOn: stringerId)

        if let stringerDTO = dto {
            return dataControl.createObject(fromObject: stringerDTO, toObject: Stringer.self)
        } else {
            return nil
        }
    }

    func postStringer(stringer: Stringer) throws {
        try teamDAO.postStringer(stringer: stringer)
    }

    /**
     Put a stringer to the database. Uses the stringers id to place the stringer in the database.

     - Parameter stringer: The stringer you want to put to the database.
     */
    func putStringer(stringer: Stringer) throws {
        let stringerDTO = dataControl.createObject(fromObject: stringer, toObject: StringerDTO.self)
        try teamDAO.putStringer(stringerDTO: stringerDTO)
    }
}
