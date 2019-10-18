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

    func getRacketStrings(by shopId: String, completion: @escaping ([RacketStringDTO]?) -> Void) {
        do {
            try dataControl.getData(returnType: [String: RacketStringDTO?].self, url: "\(Firebase.storage)/\(shopId)", completion: { (result) in
                guard let result = result else { completion(nil); return }
                    var listToReturn: [RacketStringDTO]? = []

                    for item in result {
                        if let racketString = item.value {
                            listToReturn?.append(racketString)
                        }
                    }

                completion(listToReturn)
            })
        } catch {
            completion(nil)
        }
    }

    func putRacketString(racketString: RacketStringDTO?, storageId: String, completion: @escaping (Bool) -> Void) {
        guard let racketString = racketString, let id = racketString.stringId else { completion(false); return }

        dataControl.putData(objectToUpdate: racketString, objectId: id, url: "\(Firebase.storage)/\(storageId)") { (succes) in
            completion(succes)
        }
    }
}
