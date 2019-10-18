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

    func putRacketString(racketString: RacketStringDTO?, url: String, completion: @escaping (Bool) -> Void) {
        guard let racketStringDTO = racketString, let id = racketString?.stringId else { completion(false); return}
        dataControl.putData(objectToUpdate: racketStringDTO, objectId: id, url: url) { (succes) in
            completion(succes)
        }
    }

    func getStringsInStorage(basedOnId id: String, andStringId  completion: @escaping ([RacketStringDTO]?) -> Void) {
        do {
            try dataControl.getListOfData(returnType: RacketStringDTO.self, url: "\(Firebase.storage)/\(id)") { (resultArray) in
                completion(resultArray)
            }
        } catch {
            print("something went wrong", error)
            completion(nil)
        }
    }
}
