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

    func postCustomer(customer: CustomerDto, completion: @escaping (Bool) -> Void) {
        customerDAO.postCustomer(customer: customer) { (success) in
            completion(success)
        }
    }

    func getAllCustomers(completion: @escaping ([CustomerREST]?) -> Void) {
//        var customersToReturn: [CustomerREST]? = []

        customerDAO.getAllCustomers { (customers) in
            completion(customers)
        }

//        customerDAO.getAllCustomers { (result) in
//            if let customers = result {
//                for customer in customers {
//                    let currentCustomer = self.dataControl.createObject(fromObject: customer, toObject: CustomerFb.self)
//                    if let currentCustomer = currentCustomer {
//                        customersToReturn?.append(currentCustomer)
//                    }
//                }
//            }
//
//            completion(customersToReturn)
//        }
    }

    func putCustomer(customer: CustomerREST, completion: @escaping (Bool) -> Void) {
        
//        let customerDTO = dataControl.createObject(fromObject: customer, toObject: CustomerDTOFb.self)
//        customerDAO.putCustomer(customer: customerDTO) { (succes) in
//            completion(succes)
//        }
    }
}
