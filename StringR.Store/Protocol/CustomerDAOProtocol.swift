//
//  CustomerDAOProtocol.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 15/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol CustomerDAOProtocol {
    func getCustomer(by id: String, completion: @escaping (CustomerDTOFb?) -> Void)
    func getAllCustomers(completion: @escaping ([CustomerDTOFb]?) -> Void)
    func putCustomer(customer: CustomerDTOFb?, completion: @escaping (Bool) -> Void)
    func getAllCustomers(completion: @escaping ([CustomerREST]?) -> Void)
    func postCustomer(customer: CustomerDto, completion: @escaping (Bool) -> Void)
}
