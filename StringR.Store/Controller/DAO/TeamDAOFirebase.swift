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
        dataControl.putData(objectToUpdate: stringerDTO, objectId: id, url: Firebase.stringer) { (outSucces) in

            ShopSingleton.shared.getShop(completion: { (shop) in
                if let shop = shop {
                    self.dataControl.getData(returnType: Team.self, url: "\(Firebase.team)/\(shop.teamId)", completion: { (team) in
                        if var teamStringers = team?.stringerIds {
                            teamStringers.append(id)
                            team?.stringerIds = teamStringers
                        } else {
                            let array = [id]
                            team?.stringerIds = array
                        }

                        if let team = team {
                            self.putTeam(team: team, completion: { (innerSucces) in
                                completion(innerSucces && outSucces)
                            })
                        }
                    })
                }
            })
        }
    }

    func putTeam(team: Team?, completion: @escaping (Bool) -> Void) {
        guard let team = team else { completion(false); return }
        let teamDto = dataControl.createObject(fromObject: team, toObject: TeamDTO.self)
        if let id = teamDto?.teamId {
            dataControl.putData(objectToUpdate: teamDto, objectId: id, url: Firebase.team) { (succes) in
                completion(succes)
            }
        }
    }
}
