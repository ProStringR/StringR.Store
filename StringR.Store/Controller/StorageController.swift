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

    func getRacketStrings(by shopId: String, completion: @escaping ([RacketString]?) -> Void) {
        var racketStringsToReturn: [RacketString]? = []

        storageDAO.getRacketStrings(by: shopId, completion: { (result) in
            if let racketStrings = result {
                for racketString in racketStrings {
                    let currentRacketString = self.dataControl.createObject(fromObject: racketString, toObject: RacketString.self)
                    if let currentRacketString = currentRacketString {
                        racketStringsToReturn?.append(currentRacketString)
                    }
                }
            }

            completion(racketStringsToReturn)
        })
    }

    func putRacketString(racketString: RacketString, storageId: String, completion: @escaping (Bool) -> Void) {

        let racketStringDTO = dataControl.createObject(fromObject: racketString, toObject: RacketStringDTO.self)
        storageDAO.putRacketString(racketString: racketStringDTO, storageId: storageId) { (succes) in
            completion(succes)
        }
    }

    func filterStrings(racketStrings: [RacketString], by purpose: RacketType) -> [RacketString] {

        var stringsToReturn: [RacketString] = []

        for string in racketStrings where string.stringPurpose == purpose {
            stringsToReturn.append(string)
        }

        return stringsToReturn
    }
}
