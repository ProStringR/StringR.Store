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
    let storageDAO: StorageDAOProtocol = ControlReg.getStorageDAO
    let racketStringDao: RacketDAOProtocol = ControlReg.getRacketDAO

    func postRacketString(racket: RacketStringDto?, completion: @escaping (Bool) -> Void) {
        if let racket = racket {
            racketStringDao.postRacketString(racketString: racket) { (success) in
                completion(success)
            }
        }
    }

    func putRacketString(racketString: RacketStringFb, storageId: String, completion: @escaping (Bool) -> Void) {
        let racketStringDTO = dataControl.createObject(fromObject: racketString, toObject: RacketStringDTOFb.self)
        storageDAO.putRacketString(racketString: racketStringDTO, storageId: storageId) { (succes) in
            completion(succes)
        }
    }

    func getStringInStorage(basedOnShopAndString id: String, completion: @escaping (RacketStringFb?) -> Void) {
        storageDAO.getStringsInStorage(basedOnId: id) { (dto) in
            if let racketStringDTO = dto {
                let racketString = self.dataControl.createObject(fromObject: racketStringDTO, toObject: RacketStringFb.self)
                completion(racketString)
            } else {
                completion(nil)
            }
        }
    }

    func getListOfStringsInStorage(fromShopId id: String, completion: @escaping ([RacketStringFb]?) -> Void) {
        storageDAO.getStringsInStorage(basedOnId: id) { (resultArray) in
            if let racketStringDtoArray = resultArray {
                var racketStrings: [RacketStringFb] = []

                for dto in racketStringDtoArray {
                    let racketString = self.dataControl.createObject(fromObject: dto, toObject: RacketStringFb.self)

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

    func removeSpecificLengthFromRacketString(racketString: RacketStringFb, length: Double, storageId: String, completion: @escaping (Bool) -> Void) {
        racketString.removeLength(length: length)

        putRacketString(racketString: racketString, storageId: storageId) { (succes) in
            completion(succes)
        }
    }

    func filterStrings(racketStrings: [RacketStringFb], by purpose: RacketType) -> [RacketStringFb] {

        var stringsToReturn: [RacketStringFb] = []

        for string in racketStrings where string.stringPurpose == purpose {
            stringsToReturn.append(string)
        }

        return stringsToReturn
    }

    func deleteStringFromStorage(fromShop shopId: String, stringId: String, completion: @escaping (Bool) -> Void) {
        storageDAO.deleteStringFromStorage(fromShop: shopId, stringId: stringId) { (succes) in
            completion(succes)
        }
    }
}
