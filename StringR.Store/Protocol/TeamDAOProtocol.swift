//
//  TeamDAOProtocol.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 30/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol TeamDAOProtocol {
    func postStringer(stringer: Stringer) throws
    func putStringer(stringerDTO: StringerDTO?) throws
    func putTeam(team: TeamDTO?) throws
    func getStringer(basedOn stringerId: String, completion: @escaping (StringerDTO?) -> Void)
    func getTeam(basedOn teamId: String, completion: @escaping (TeamDTO?) -> Void)
}
