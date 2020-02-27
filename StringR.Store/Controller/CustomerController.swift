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

    func getCustomer(by id: String, completion: @escaping (CustomerFb?) -> Void) {
        customerDAO.getCustomer(by: id) { (result) in
            completion(self.dataControl.createObject(fromObject: result, toObject: CustomerFb.self))
        }
    }

    func getAllCustomers(completion: @escaping ([CustomerFb]?) -> Void) {
        var customersToReturn: [CustomerFb]? = []

        customerDAO.getAllCustomers { (result) in
            if let customers = result {
                for customer in customers {
                    let currentCustomer = self.dataControl.createObject(fromObject: customer, toObject: CustomerFb.self)
                    if let currentCustomer = currentCustomer {
                        customersToReturn?.append(currentCustomer)
                    }
                }
            }

            completion(customersToReturn)
        }
    }

    func putCustomer(customer: CustomerFb, completion: @escaping (Bool) -> Void) {
        let customerDTO = dataControl.createObject(fromObject: customer, toObject: CustomerDTOFb.self)
        customerDAO.putCustomer(customer: customerDTO) { (succes) in
            completion(succes)
        }
    }
}
