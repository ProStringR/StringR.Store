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

    func getStringer(basedOn stringerId: String, completion: @escaping (StringerDTO?) -> Void) {
        dataControl.getData(returnType: StringerDTO.self, url: "\(Firebase.stringer)/\(stringerId)", completion: { (result) in
            completion(result)
        })
    }

    func getTeam(basedOn teamId: String, completion: @escaping (TeamDTO?) -> Void) {
        dataControl.getData(returnType: TeamDTO.self, url: "\(Firebase.team)/\(teamId)", completion: { (result) in
            completion(result)
        })
    }

    func postStringer(stringer: Stringer) throws {
        try dataControl.postData(object: stringer, url: Firebase.stringer)
    }

    func putStringer(stringer: StringerDTO?, completion: @escaping (Bool) -> Void) {
        guard let stringerDTO = stringer, let id = stringerDTO.userId else { completion(false); return }
        dataControl.putData(objectToUpdate: stringerDTO, objectId: id, url: Firebase.stringer) { (succes) in
            completion(succes)
        }
    }

    func putTeam(team: TeamDTO?, completion: @escaping (Bool) -> Void) {
        guard let team = team, let id = team.teamId else { completion(false); return }
        dataControl.putData(objectToUpdate: team, objectId: id, url: Firebase.team) { (succes) in
            completion(succes)
        }
    }
}
