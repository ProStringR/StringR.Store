//
//  CustomerDaoSql.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 02/03/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class CustomerDaoSql: CustomerDAOProtocol {
    let dataControl = ControlReg.getDataController

    func getAllCustomers(completion: @escaping ([CustomerREST]?) -> Void) {
        dataControl.getDataREST(returnType: [CustomerREST].self, url: "\(Constant.customers)/all-customers") { (customers) in
            completion(customers)
        }
    }

    func getCustomer(by id: String, completion: @escaping (CustomerDTOFb?) -> Void) {
        print("wrong implementation")
    }

    func getAllCustomers(completion: @escaping ([CustomerDTOFb]?) -> Void) {
        print("wrong implementation")
    }

    func putCustomer(customer: CustomerDTOFb?, completion: @escaping (Bool) -> Void) {
        print("wrong implementation")
    }

    func postCustomer(customer: CustomerDto, completion: @escaping (Bool) -> Void) {
        dataControl.postDataREST(object: customer, url: Constant.customers) { (success) in
            completion(success)
        }
    }
}
