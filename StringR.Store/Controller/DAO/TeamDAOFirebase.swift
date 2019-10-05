//
//  TeamDAOFirebase.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 30/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class TeamDAOFirebase: TeamDAOProtocol {

    let dataControl = ControlReg.getDataController

    func getStringer(basedOn stringerId: String) -> StringerDTO? {
        do {
            let stringer = try dataControl.getData(returnType: StringerDTO.self, url: "\(Firebase.stringer)/\(stringerId)")
            return stringer
        } catch {
            return nil
        }
    }

    func getStringerTest(basedOn stringerId: String, completion: @escaping (StringerDTO?) -> Void) {
        do {
            try dataControl.getDataTest(returnType: StringerDTO.self, url: "\(Firebase.stringer)/\(stringerId)", completion: { (result) in
                completion(result)
            })
        } catch {
            completion(nil)
        }
    }

    func getTeam(basedOn teamId: String) -> TeamDTO? {
        do {
            let team = try dataControl.getData(returnType: TeamDTO.self, url: "\(Firebase.team)/\(teamId)")
            return team
        } catch {
            return nil
        }
    }

    func getTeamTest(basedOn teamId: String, completion: @escaping (TeamDTO?) -> Void) {
        do {
            try dataControl.getDataTest(returnType: TeamDTO.self, url: "\(Firebase.team)/\(teamId)", completion: { (result) in
                completion(result)
            })
        } catch {
            completion(nil)
        }
    }

    func postStringer(stringer: Stringer) throws {
        try dataControl.postData(object: stringer, url: Firebase.stringer)
    }

    func putStringer(stringerDTO: StringerDTO?) throws {
        guard let stringerDTO = stringerDTO, let id = stringerDTO.userId else { throw Exception.nilPoint }
        try dataControl.putData(objectToUpdate: stringerDTO, objectId: id, url: Firebase.stringer)
    }

    func putTeam(team: TeamDTO?) throws {
        guard let team = team, let id = team.teamId else { throw Exception.nilPoint }
        try dataControl.putData(objectToUpdate: team, objectId: id, url: Firebase.team)
    }
}
