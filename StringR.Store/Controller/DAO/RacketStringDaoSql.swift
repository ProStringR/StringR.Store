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

    func getRacketString(by id: String, storageId: String, completion: @escaping (RacketStringFb?) -> Void) {
        print("do nothing")
    }

    func deleteStringFromStorage(fromShop shopId: String, stringId: String, completion: @escaping (Bool) -> Void) {
        print("do nothing")
    }

    func putRacketString(racketString: RacketStringDTOFb?, storageId: String, completion: @escaping (Bool) -> Void) {
        print("do nothing")
    }

    func getStringsInStorage(basedOnId id: String, completion: @escaping ([RacketStringDTOFb]?) -> Void) {
        print("do nothing")
    }

    func getStringsInStorage(basedOnId id: String, completion: @escaping ([RacketStringREST]?) -> Void) {
        dataControl.getDataREST(returnType: [RacketStringREST].self, url: "") { (results) in
            completion(results)
        }
    }

    func postRacketString(racketString: RacketStringDto, completion: @escaping (Bool) -> Void) {
        do {
            try dataControl.postDataREST(object: racketString, url: Constant.postRacketString)
        } catch {
            print(error)
        }
    }
}
