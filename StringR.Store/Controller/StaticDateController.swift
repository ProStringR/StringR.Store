//
//  StaticDateController.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 28/02/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class StaticDataController {
    private let staticDataDao: StaticDataDaoProtocol = ControlReg.getStaticDataDao

    func getAllColors(completion: @escaping ([StringColorREST]?) -> Void) {
        staticDataDao.getAllColors { (colors) in
            completion(colors)
        }
    }

    func getAllPurposes(completion: @escaping ([PurposeREST]?) -> Void) {
        staticDataDao.getAllPurposes { (purposes) in
            completion(purposes)
        }
    }

    func getAllRacketBrands(completion: @escaping ([RacketBrandREST]?) -> Void) {
        staticDataDao.getAllRacketBrands { (racketBrands) in
            completion(racketBrands)
        }
    }

    func getAllStringBrands(completion: @escaping ([StringBrandREST]?) -> Void) {
        staticDataDao.getAllStringBrands { (stringBrands) in
            completion(stringBrands)
        }
    }

    func getAllStringTypes(completion: @escaping ([StringTypesREST]?) -> Void) {
        staticDataDao.getAllStringTypes { (stringBrands) in
            completion(stringBrands)
        }
    }
}
