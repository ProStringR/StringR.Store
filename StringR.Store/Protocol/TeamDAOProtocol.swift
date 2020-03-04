//
//  TeamDAOProtocol.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 30/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol TeamDAOProtocol {
    func getTeamForShop(teamId: String, completion: @escaping ([StringerREST]?) -> Void)
    func postStringerToTeam(teamId: Int, with stringer: StringerDto, completion: @escaping (Bool) -> Void)
}
