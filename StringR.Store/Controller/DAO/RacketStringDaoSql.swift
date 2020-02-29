//
//  RacketStringDaoSql.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 28/02/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class RacketStringDaoSql: RacketDAOProtocol {

    let dataControl = ControlReg.getDataController

    func getRacket(racketId: String, completion: @escaping (RacketFb?) -> Void) {
        print("do nothing")
    }

    func putRacket(racket: RacketFb, completion: @escaping (Bool) -> Void) {
        print("do nothing")
    }

    func putTempRacket(racket: RacketFb, completion: @escaping (Bool) -> Void) {
        print("do nothing")
    }

    func postRacketString(racketString: RacketStringDto, completion: @escaping (Bool) -> Void) {
        do {
            try dataControl.postDataREST(object: racketString, url: Constant.postRacketString)
        } catch {
            print(error)
        }
    }
}
