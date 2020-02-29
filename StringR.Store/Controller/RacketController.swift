//
//  RacketController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 24/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class RacketController {

    let racketDAO: RacketDAOProtocol = ControlReg.getRacketDAO

    func getRacket(racketId: String, completion: @escaping (RacketFb?) -> Void) {
        racketDAO.getRacket(racketId: racketId) { (result) in
            completion(result)
        }
    }

    func putRacket(racket: RacketFb, completion: @escaping (Bool) -> Void) {
        racketDAO.putRacket(racket: racket) { (succes) in
            completion(succes)
        }
    }

    func putTempRacket(racket: RacketFb, completion: @escaping (Bool) -> Void) {
        racketDAO.putTempRacket(racket: racket) { (succes) in
            completion(succes)
        }
    }
}
