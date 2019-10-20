//
//  StorageDAOFirebase.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 16/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class StorageDAOFirebase: StorageDAOProtocol {
    let dataControl = ControlReg.getDataController

    func getRacketString(by id: String, storageId: String, completion: @escaping (RacketString?) -> Void) {
        dataControl.getData(returnType: RacketStringDTO.self, url: "\(Firebase.storage)/\(storageId)/\(id)") { (result) in
            completion(self.dataControl.createObject(fromObject: result, toObject: RacketString.self))
        }
    }

    func putRacketString(racketString: RacketStringDTO?, storageId: String, completion: @escaping (Bool) -> Void) {
        guard let racketStringDTO = racketString, let id = racketString?.stringId else { completion(false); return}
        dataControl.putData(objectToUpdate: racketStringDTO, objectId: id, url: "\(Firebase.storage)/\(storageId)") { (succes) in
            completion(succes)
        }
    }

    func getStringsInStorage(basedOnId id: String, completion: @escaping ([RacketStringDTO]?) -> Void) {
        dataControl.getListOfData(returnType: RacketStringDTO.self, url: "\(Firebase.storage)/\(id)") { (resultArray) in
            completion(resultArray)
        }
    }

    func deleteStringFromStorage(fromShop shopId: String, stringId: String, completion: @escaping (Bool) -> Void) {
        dataControl.deleteData(objectIdToDelete: stringId, url: "\(Firebase.storage)/\(shopId)") { (succes) in
            completion(succes)
        }
    }
}
