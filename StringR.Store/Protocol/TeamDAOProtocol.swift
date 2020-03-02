//
//  TeamDAOProtocol.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 30/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol TeamDAOProtocol {
    func getStringer(basedOn stringerId: String, completion: @escaping (StringerDTOFb?) -> Void)
    func getTeam(basedOn teamId: String, completion: @escaping (TeamDTOFb?) -> Void)
    func putStringer(stringer: StringerFb?, completion: @escaping (Bool) -> Void)
    func putStringerToTeam(stringer: StringerDTOFb?, completion: @escaping (Bool) -> Void)
    func putTeam(team: TeamFb?, completion: @escaping (Bool) -> Void)
    func getTeamForShop(shopId: String, completion: @escaping ([StringerREST]?) -> Void)
}
