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

    func postStringer(stringer: Stringer) throws {
        try dataControl.postData(object: stringer, url: Firebase.stringer)
    }

    func putStringer(stringerDTO: StringerDTO?) throws {
        guard let stringerDTO = stringerDTO, let id = stringerDTO.userId else { throw Exception.nilPoint }

        try dataControl.putData(objectToUpdate: stringerDTO, objectId: id, url: Firebase.stringer)
    }

}
