//
//  StringTypeSingleton.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 28/02/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class StringTypeSingleton {
    let staticDataController = ControlReg.getStaticDataController

    static let shared = StringTypeSingleton()

    var stringTypes: [StringTypesREST]?

    private init() { }

    func getAllStringTypes(completion: @escaping ([StringTypesREST]?) -> Void) {
        if let stringTypes = self.stringTypes {
            completion(stringTypes)
            return
        }

        staticDataController.getAllStringTypes { (stringTypes) in
            if let stringTypes = stringTypes {
                self.stringTypes = stringTypes
                completion(stringTypes)
            }
        }
    }
}
