//
//  RacketBrandSingleton.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 28/02/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class RacketBrandSingleton {
    let staticDataController = ControlReg.getStaticDataController

    static let shared = RacketBrandSingleton()

    var racketBrands: [RacketBrandREST]?

    private init() { }

    func getAllRacketBrands(completion:@escaping ([RacketBrandREST]?) -> Void) {
        if let racketBrands = self.racketBrands {
            completion(racketBrands)
            return
        }

        staticDataController.getAllRacketBrands { (racketBrands) in
            if let racketBrands = racketBrands {
                self.racketBrands = racketBrands
                completion(racketBrands)
            }
        }
    }
}
