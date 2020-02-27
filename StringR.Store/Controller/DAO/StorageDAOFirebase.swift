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

    func getRacketString(by id: String, storageId: String, completion: @escaping (RacketStringFb?) -> Void) {
        dataControl.getData(returnType: RacketStringDTOFb.self, url: "\(Firebase.storage)/\(storageId)/\(id)") { (result) in
            completion(self.dataControl.createObject(fromObject: result, toObject: RacketStringFb.self))
        }
    }

    func putRacketString(racketString: RacketStringDTOFb?, storageId: String, completion: @escaping (Bool) -> Void) {
        guard let racketStringDTO = racketString, let id = racketString?.stringId else { completion(false); return}
        dataControl.putData(objectToUpdate: racketStringDTO, objectId: id, url: "\(Firebase.storage)/\(storageId)") { (succes) in
            completion(succes)
        }
    }

    func getStringsInStorage(basedOnId id: String, completion: @escaping ([RacketStringDTOFb]?) -> Void) {
        dataControl.getListOfData(returnType: RacketStringDTOFb.self, url: "\(Firebase.storage)/\(id)") { (resultArray) in
            completion(resultArray)
        }
    }

    func deleteStringFromStorage(fromShop shopId: String, stringId: String, completion: @escaping (Bool) -> Void) {
        dataControl.deleteData(objectIdToDelete: stringId, url: "\(Firebase.storage)/\(shopId)") { (succes) in
            completion(succes)
        }
    }
}
