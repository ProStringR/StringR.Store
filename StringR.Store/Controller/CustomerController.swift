//
//  CustomerController.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 15/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class CustomerController {

    private let dataControl = ControlReg.getDataController
    private let customerDAO: CustomerDAOProtocol = ControlReg.getCustomerDAO

    func postCustomer(customer: CustomerDto, completion: @escaping (Bool) -> Void) {
        customerDAO.postCustomer(customer: customer) { (success) in
            completion(success)
        }
    }

    func getAllCustomers(completion: @escaping ([CustomerREST]?) -> Void) {
        customerDAO.getAllCustomers { (customers) in
            completion(customers)
        }
    }
}
