//
//  StringBrandSingleton.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 28/02/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class StringBrandSingleton {
    let staticDataController = ControlReg.getStaticDataController

    static let shared = StringBrandSingleton()

    var stringBrands: [StringBrandREST]?

    private init() { }

    func fetchData() {
        if stringBrands == nil {
            staticDataController.getAllStringBrands { (stringBrands) in
                if let stringBrands = stringBrands {
                    self.stringBrands = stringBrands
                }
            }
        }
    }

    func getAllStringBrands(completion: @escaping ([StringBrandREST]?) -> Void) {
        if let stringBrands = self.stringBrands {
            completion(stringBrands)
            return
        }

        staticDataController.getAllStringBrands { (stringBrands) in
            if let stringBrands = stringBrands {
                self.stringBrands = stringBrands
                completion(stringBrands)
            }
        }
    }
}
