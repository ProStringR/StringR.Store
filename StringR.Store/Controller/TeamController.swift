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

    func getStringer(basedOn stringerId: String, completion: @escaping (StringerFb?) -> Void) {

        teamDAO.getStringer(basedOn: stringerId) { (dto) in
            if let stringerDTO = dto {
                let stringer = self.dataControl.createObject(fromObject: stringerDTO, toObject: StringerFb.self)
                completion(stringer)
            } else {
                completion(nil)
            }
        }
    }

    func getTeam(basedOn teamId: String, completion: @escaping (TeamFb?) -> Void) {

        teamDAO.getTeam(basedOn: teamId) { (dto) in
            if let teamDTO = dto {
                let team = self.dataControl.createObject(fromObject: teamDTO, toObject: TeamFb.self)
                completion(team)
            } else {
                completion(nil)
            }
        }
    }

    func getStringers(fromTeamId id: String, completion: @escaping ([StringerFb]?) -> Void) {
        getTeam(basedOn: id) { (team) in
            var stringers: [StringerFb] = []

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

    func putStringer(stringer: StringerFb, completion: @escaping (Bool) -> Void) {
        teamDAO.putStringer(stringer: stringer) { (succes) in
            completion(succes)
        }
    }

    func putStringerToTeam(stringer: StringerFb, completion: @escaping (Bool) -> Void) {
        let stringerDTO = dataControl.createObject(fromObject: stringer, toObject: StringerDTOFb.self)
        teamDAO.putStringerToTeam(stringer: stringerDTO) { (succes) in
            completion(succes)
        }
    }

    func putTeam(team: TeamFb, completion: @escaping (Bool) -> Void) {
        teamDAO.putTeam(team: team) { (succes) in
            completion(succes)
        }
    }

    func createTeam(of stringers: [StringerFb]?, withId id: String) -> TeamFb? {
        guard let stringers = stringers else { return nil }
        var ids: [String] = []

        for stringer in stringers {
            ids.append(stringer.userId)
        }

        let team = TeamFb(teamId: id)
        team.stringerIds = ids

        return team
    }
}
