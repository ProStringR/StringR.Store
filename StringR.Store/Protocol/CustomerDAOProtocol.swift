//
//  CustomerDAOProtocol.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 15/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol CustomerDAOProtocol {
    func getAllCustomers(completion: @escaping ([CustomerREST]?) -> Void)
    func postCustomer(customer: CustomerDto, completion: @escaping (Bool) -> Void)
}
