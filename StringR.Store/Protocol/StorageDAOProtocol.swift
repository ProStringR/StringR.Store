//
//  File.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 16/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol StorageDAOProtocol {
    func getRacketString(by id: String, completion: @escaping (RacketString?) -> Void)
    func putRacketString(racketString: RacketStringDTO?, storageId: String, completion: @escaping (Bool) -> Void)
    func getStringsInStorage(basedOnId id: String, completion: @escaping ([RacketStringDTO]?) -> Void)
}
