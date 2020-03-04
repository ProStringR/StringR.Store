//
//  File.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 16/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol StorageDAOProtocol {
    func putStringPurchaseHistoryItem(for item: PurchaseHistoryREST, completion: @escaping (Bool) -> Void)
    func getStringsInStorage(basedOnId id: String, completion: @escaping ([RacketStringREST]?) -> Void)
    func deleteString(stringId: Int, completion: @escaping (Bool) -> Void)
    func postRacketString(racketString: RacketStringDto, completion: @escaping (Bool) -> Void)
}
