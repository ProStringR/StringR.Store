//
//  StorageController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 22/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class StorageController {

    let storageDAO: StorageDAOProtocol = ControlReg.getStorageDAO

    func postRacketString(racket: RacketStringDto?, completion: @escaping (Bool) -> Void) {
        if let racket = racket {
            storageDAO.postRacketString(racketString: racket) { (success) in
                completion(success)
            }
        }
    }

    func getStringsForShop(by shopId: String, completion: @escaping ([RacketStringREST]?) -> Void) {
        storageDAO.getStringsInStorage(basedOnId: shopId) { (racketStrings) in
            completion(racketStrings)
        }
    }

    func putStringPurchaseHistoryItem(for item: PurchaseHistoryREST, completion: @escaping (Bool) -> Void) {
        storageDAO.putStringPurchaseHistoryItem(for: item) { (success) in
            completion(success)
        }
    }

    func deleteString(stringId: Int, completion: @escaping (Bool) -> Void) {
        storageDAO.deleteString(stringId: stringId) { (success) in
            completion(success)
        }
    }

    func filterStrings(racketStrings: [RacketStringREST], by purpose: RacketType) -> [RacketStringREST] {
        var stringsToReturn: [RacketStringREST] = []

        racketStrings.forEach { (racketString) in
            if let stringPurpose = racketString.stringPurpose {
                if stringPurpose == purpose.rawValue {
                    stringsToReturn.append(racketString)
                }
            }
        }

        return stringsToReturn
    }
}
