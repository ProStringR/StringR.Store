//
//  StorageController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 22/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class StorageController {

    let dataControl = ControlReg.getDataController
    let storageDAO = ControlReg.getStorageDAO

    func putRacketString(racketString: RacketString, completion: @escaping (Bool) -> Void) {
        let racketStringDTO = dataControl.createObject(fromObject: racketString, toObject: RacketStringDTO.self)
        storageDAO.putRacketString(racketString: racketStringDTO) { (succes) in
            completion(succes)
        }
    }
}
