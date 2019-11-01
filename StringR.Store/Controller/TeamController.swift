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

    func getStringer(basedOn stringerId: String, completion: @escaping (Stringer?) -> Void) {

        teamDAO.getStringer(basedOn: stringerId) { (dto) in
            if let stringerDTO = dto {
                let stringer = self.dataControl.createObject(fromObject: stringerDTO, toObject: Stringer.self)
                completion(stringer)
            } else {
                completion(nil)
            }
        }
    }

    func getTeam(basedOn teamId: String, completion: @escaping (Team?) -> Void) {

        teamDAO.getTeam(basedOn: teamId) { (dto) in
            if let teamDTO = dto {
                let team = self.dataControl.createObject(fromObject: teamDTO, toObject: Team.self)
                completion(team)
            } else {
                completion(nil)
            }
        }
    }

    func getStringers(fromTeamId id: String, completion: @escaping ([Stringer]?) -> Void) {
        getTeam(basedOn: id) { (team) in
            var stringers: [Stringer] = []

            if let team = team, let ids = team.stringerIds {
                var attempts = 0
                for id in ids {
                    self.getStringer(basedOn: id) { (stringer) in
                        attempts += 1
                        if let currentStringer = stringer {
                            stringers.append(currentStringer)

                            if attempts == ids.count {
                                completion(stringers)
                            }
                        }
                    }
                }
            } else {
                completion(nil)
            }
        }
    }

    func postStringer(stringer: Stringer) throws {
        try teamDAO.postStringer(stringer: stringer)
    }

    func putStringer(stringer: Stringer, completion: @escaping (Bool) -> Void) {
        teamDAO.putStringer(stringer: stringer) { (succes) in
            completion(succes)
        }
    }

    /**
     Put a stringer to the database. Uses the stringers id to place the stringer in the database.

     - Parameter stringer: The stringer you want to put to the database.
     */
    func putStringerToTeam(stringer: Stringer, completion: @escaping (Bool) -> Void) {
        let stringerDTO = dataControl.createObject(fromObject: stringer, toObject: StringerDTO.self)
        teamDAO.putStringerToTeam(stringer: stringerDTO) { (succes) in
            completion(succes)
        }
    }

    func putTeam(team: Team, completion: @escaping (Bool) -> Void) {
        teamDAO.putTeam(team: team) { (succes) in
            completion(succes)
        }
    }

    /**
        Generate a Team based on a list of Stringers. The Team consist of a teamId and a list of stringerIds

     - Parameter of: The list of stringers you want to make to a Team.
     - Parameter withId: The id of the Team.
     */
    func createTeam(of stringers: [Stringer]?, withId id: String) -> Team? {
        guard let stringers = stringers else { return nil }
        var ids: [String] = []

        for stringer in stringers {
            ids.append(stringer.userId)
        }

        let team = Team(teamId: id)
        team.stringerIds = ids

        return team
    }
}
