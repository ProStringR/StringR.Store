//
//  StorageController.swift
//  StringR.Store
//
//  Created by Jaafar on 17/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class StorageDAOFirebase {
    let dataControl = ControlReg.getDataController

    func putRacketString(racketString: RacketStringDTO?, completion: @escaping (Bool) -> Void) {
        guard let racketStringDTO = racketString, let id = racketString?.stringId else { completion(false); return}
        dataControl.putData(objectToUpdate: racketStringDTO, objectId: id, url: Firebase.storage) { (succes) in
            completion(succes)
        }
    }
}
