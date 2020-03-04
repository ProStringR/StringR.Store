//
//  TeamDaoSql.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 02/03/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class TeamDaoSql: TeamDAOProtocol {
    let dataControl = ControlReg.getDataController

    func getTeamForShop(teamId: String, completion: @escaping ([StringerREST]?) -> Void) {
        dataControl.getDataREST(returnType: [StringerREST].self, url: "\(Constant.stringers)/shop/\(teamId)") { (stringers) in
            completion(stringers)
        }
    }

    func postStringerToTeam(teamId: Int, with stringer: StringerDto, completion: @escaping (Bool) -> Void) {
        dataControl.postDataREST(object: stringer, url: "\(Constant.stringers)/\(teamId)") { (success) in
            completion(success)
        }
    }
}
