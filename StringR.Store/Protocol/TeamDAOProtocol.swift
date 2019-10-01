//
//  TeamDAOProtocol.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 30/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol TeamDAOProtocol {
    func getStringer(basedOn stringerId: String) -> StringerDTO?
    func postStringer(stringer: Stringer) throws
    func putStringer(stringerDTO: StringerDTO?) throws
}
