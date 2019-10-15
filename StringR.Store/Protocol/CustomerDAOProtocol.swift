//
//  CustomerDAOProtocol.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 15/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol CustomerDAOProtocol {
    func getCustomer(by id: String, completion: @escaping (CustomerDTO?) -> Void)
    func getAllCustomers(completion: @escaping ([CustomerDTO]?) -> Void)
    func putCustomer(customer: CustomerDTO?, completion: @escaping (Bool) -> Void)
}
