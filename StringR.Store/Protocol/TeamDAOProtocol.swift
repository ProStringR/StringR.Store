//
//  TeamDAOProtocol.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 30/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol TeamDAOProtocol {
    func getStringer(basedOn stringerId: String, completion: @escaping (StringerDTO?) -> Void)
    func getTeam(basedOn teamId: String, completion: @escaping (TeamDTO?) -> Void)
    func putStringer(stringer: Stringer?, completion: @escaping (Bool) -> Void)
    func putStringerToTeam(stringer: StringerDTO?, completion: @escaping (Bool) -> Void)
    func putTeam(team: Team?, completion: @escaping (Bool) -> Void)
}
