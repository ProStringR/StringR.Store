//
//  RacketStringDaoSql.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 28/02/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class StorageDaoSql: StorageDAOProtocol {

    let dataControl = ControlReg.getDataController

    func getStringsInStorage(basedOnId id: String, completion: @escaping ([RacketStringREST]?) -> Void) {
        let url = "\(Constant.getRacketStringsForShop)/\(id)"
        dataControl.getDataREST(returnType: [RacketStringREST].self, url: url) { (results) in
            completion(results)
        }
    }

    func postRacketString(racketString: RacketStringDto, completion: @escaping (Bool) -> Void) {
        dataControl.postDataREST(object: racketString, url: Constant.racketString, completion: { (success) in
            completion(success)
        })
    }

    func putStringPurchaseHistoryItem(for item: PurchaseHistoryREST, completion: @escaping (Bool) -> Void) {
        if let racketStringId = item.racketStringId {
            dataControl.putDataREST(object: item, url: "\(Constant.racketString)/shop/\(racketStringId)") { (success) in
                completion(success)
            }
        }
    }

    func deleteString(stringId: Int, completion: @escaping (Bool) -> Void) {
        dataControl.deleteDataREST(object: stringId, url: "\(Constant.racketString)/delete/\(stringId)") { (success) in
            completion(success)
        }
    }
}
