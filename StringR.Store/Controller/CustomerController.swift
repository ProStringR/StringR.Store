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

    func getCustomer(by id: String, completion: @escaping (Customer?) -> Void) {
        customerDAO.getCustomer(by: id) { (result) in
            completion(self.dataControl.createObject(fromObject: result, toObject: Customer.self))
        }
    }

    func getAllCustomers(completion: @escaping ([Customer]?) -> Void) {
        var customersToReturn: [Customer]? = []

        customerDAO.getAllCustomers { (result) in
            if let customers = result {
                for customer in customers {
                    let currentCustomer = self.dataControl.createObject(fromObject: customer, toObject: Customer.self)
                    if let currentCustomer = currentCustomer {
                        customersToReturn?.append(currentCustomer)
                    }
                }
            }

            completion(customersToReturn)
        }
    }

    func putCustomer(customer: Customer, completion: @escaping (Bool) -> Void) {
        let customerDTO = dataControl.createObject(fromObject: customer, toObject: CustomerDTO.self)
        customerDAO.putCustomer(customer: customerDTO) { (succes) in
            completion(succes)
        }
    }
}
