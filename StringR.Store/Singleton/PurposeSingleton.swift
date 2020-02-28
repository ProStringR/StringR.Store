//
//  PurposeSingleton.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 28/02/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class PurposeSingleton {
    let staticDataController = ControlReg.getStaticDataController

    static let shared = PurposeSingleton()

    var purposes: [PurposeREST]?

    private init() { }

    func getAllPurposes(completion: @escaping ([PurposeREST]?) -> Void) {
        if let purposes = self.purposes {
            completion(purposes)
            return
        }

        staticDataController.getAllPurposes { (purposes) in
            if let purposes = purposes {
                self.purposes = purposes
                completion(purposes)
            }
        }
    }
}
