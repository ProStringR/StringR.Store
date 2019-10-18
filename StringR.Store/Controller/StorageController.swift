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

    func putRacketString(racketString: RacketString, url: String, completion: @escaping (Bool) -> Void) {
        let racketStringDTO = dataControl.createObject(fromObject: racketString, toObject: RacketStringDTO.self)
        storageDAO.putRacketString(racketString: racketStringDTO, url: url) { (succes) in
            completion(succes)
        }
    }

    func getStringInStorage(basedOn id: String, completion: @escaping (RacketString?) -> Void) {
        storageDAO.getStringsInStorage(basedOnShopId: id) { (dto) in
            if let racketStringDTO = dto {
                let racketString = self.dataControl.createObject(fromObject: racketStringDTO, toObject: RacketString.self)
                completion(racketString)
            } else {
                completion(nil)
            }
        }
    }

    func getListOfStringsInStorage(fromShopId id: String, completion: @escaping ([RacketString]?) -> Void) {
        storageDAO.getStringsInStorage(basedOnShopId: id) { (resultArray) in
            if let racketStringDtoArray = resultArray {
                var racketStrings: [RacketString] = []

                for dto in racketStringDtoArray {
                    let racketString = self.dataControl.createObject(fromObject: dto, toObject: RacketString.self)

                    if let racketString = racketString {
                        racketStrings.append(racketString)
                    }
                }

                completion(racketStrings)
            } else {
                completion(nil)
            }
        }
    }
}
