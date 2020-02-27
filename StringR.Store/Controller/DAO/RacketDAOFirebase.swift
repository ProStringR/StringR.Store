//
//  RacketDAOFirebase.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 24/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class RacketDAOFirebase: RacketDAOProtocol {

    let dataControl = ControlReg.getDataController

    func getRacket(racketId: String, completion: @escaping (RacketFb?) -> Void) {
        dataControl.getData(returnType: RacketDTOFb.self, url: "\(Firebase.racket)/\(racketId)") { (result) in
            completion(self.dataControl.createObject(fromObject: result, toObject: RacketFb.self))
        }
    }

    func putRacket(racket: RacketFb, completion: @escaping (Bool) -> Void) {
        let dto = self.dataControl.createObject(fromObject: racket, toObject: RacketDTOFb.self)

        guard let object = dto, let id = dto?.racketId else { completion(false); return }

        dataControl.putData(objectToUpdate: object, objectId: id, url: Firebase.racket) { (succes) in
            completion(succes)
        }
    }

    func putTempRacket(racket: RacketFb, completion: @escaping (Bool) -> Void) {
        let dto = self.dataControl.createObject(fromObject: racket, toObject: RacketDTOFb.self)

        guard let object = dto, let id = dto?.racketId else { completion(false); return }

        dataControl.putData(objectToUpdate: object, objectId: id, url: Firebase.racketDict) { (succes) in
            completion(succes)
        }
    }
}
