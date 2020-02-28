//
//  StaticDataDaoSql.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 28/02/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class StaticDataDaoSql: StaticDataDaoProtocol {
    let dataControl = ControlReg.getDataController

    func getAllColors(completion: @escaping ([StringColorREST]?) -> Void) {
        dataControl.getDataREST(returnType: [StringColorREST].self, url: Constant.allColorsStaticData) { (results) in
            completion(results)
        }
    }

    func getAllPurposes(completion: @escaping ([PurposeREST]?) -> Void) {
        dataControl.getDataREST(returnType: [PurposeREST].self, url: Constant.allPurposes) { (results) in
            completion(results)
        }
    }

    func getAllRacketBrands(completion: @escaping ([RacketBrandREST]?) -> Void) {
        dataControl.getDataREST(returnType: [RacketBrandREST].self, url: Constant.allRacketBrands) { (results) in
            completion(results)
        }
    }

    func getAllStringBrands(completion: @escaping ([StringBrandREST]?) -> Void) {
        dataControl.getDataREST(returnType: [StringBrandREST].self, url: Constant.allStringBrands) { (results) in
            completion(results)
        }
    }

    func getAllStringTypes(completion: @escaping ([StringTypesREST]?) -> Void) {
        dataControl.getDataREST(returnType: [StringTypesREST].self, url: Constant.allStringTypes) { (results) in
            completion(results)
        }
    }
}
