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

    func getStringer(basedOn stringerId: String, completion: @escaping (StringerDTOFb?) -> Void) {
        dataControl.getData(returnType: StringerDTOFb.self, url: "\(Firebase.stringer)/\(stringerId)", completion: { (result) in
            completion(result)
        })
    }

    func getTeam(basedOn teamId: String, completion: @escaping (TeamDTOFb?) -> Void) {
        dataControl.getData(returnType: TeamDTOFb.self, url: "\(Firebase.team)/\(teamId)", completion: { (result) in
            completion(result)
        })
    }

    func putStringer(stringer: StringerFb?, completion: @escaping (Bool) -> Void) {
        guard let stringer = stringer else { completion(false); return }

        dataControl.putData(objectToUpdate: stringer, objectId: stringer.userId, url: Firebase.stringer) { (succes) in
            completion(succes)
        }
    }

    func putStringerToTeam(stringer: StringerDTOFb?, completion: @escaping (Bool) -> Void) {
        guard let stringerDTO = stringer, let id = stringerDTO.userId else { completion(false); return }
        dataControl.putData(objectToUpdate: stringerDTO, objectId: id, url: Firebase.stringer) { (outSucces) in

            ShopSingleton.shared.getShop(completion: { (shop) in
                if let shop = shop {
                    self.dataControl.getData(returnType: TeamFb.self, url: "\(Firebase.team)/\(shop.teamId)", completion: { (team) in
                        if let team = team {
                            if var teamStringers = team.stringerIds {
                                teamStringers.append(id)
                                team.stringerIds = teamStringers
                            } else {
                                let array = [id]
                                team.stringerIds = array
                            }

                            self.putTeam(team: team, completion: { (innerSucces) in
                                completion(innerSucces && outSucces)
                            })
                        } else {
                            let newTeam = TeamFb(teamId: shop.teamId)
                            newTeam.stringerIds = [id]

                            self.dataControl.putData(objectToUpdate: newTeam, objectId: newTeam.teamId, url: Firebase.team) { (succes) in
                                completion(succes && outSucces)
                            }
                        }
                    })
                }
            })
        }
    }

    func putTeam(team: TeamFb?, completion: @escaping (Bool) -> Void) {
        guard let team = team else { completion(false); return }
        let teamDto = dataControl.createObject(fromObject: team, toObject: TeamDTOFb.self)
        if let id = teamDto?.teamId {
            dataControl.putData(objectToUpdate: teamDto, objectId: id, url: Firebase.team) { (succes) in
                completion(succes)
            }
        }
    }

    func getTeamForShop(shopId: String, completion: @escaping ([StringerREST]?) -> Void) {
        print("wrong implementation")
    }
}
