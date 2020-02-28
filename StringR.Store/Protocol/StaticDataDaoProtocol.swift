//
//  StaticDataDaoProtocol.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 28/02/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

protocol StaticDataDaoProtocol {
    func getAllColors(completion: @escaping ([StringColorREST]?) -> Void)
    func getAllPurposes(completion: @escaping ([PurposeREST]?) -> Void)
    func getAllRacketBrands(completion: @escaping ([RacketBrandREST]?) -> Void)
    func getAllStringBrands(completion: @escaping ([StringBrandREST]?) -> Void)
    func getAllStringTypes(completion: @escaping ([StringTypesREST]?) -> Void)
}
