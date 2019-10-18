//
//  CustomerDAOFirebase.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 15/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class CustomerDAOFirebase: CustomerDAOProtocol {

    let dataControl = ControlReg.getDataController

    func getCustomer(by id: String, completion: @escaping (CustomerDTO?) -> Void) {
        dataControl.getData(returnType: CustomerDTO.self, url: "\(Firebase.customer)/\(id)", completion: { (result) in
            completion(result)
        })
    }

    func getAllCustomers(completion: @escaping ([CustomerDTO]?) -> Void) {
        dataControl.getListOfData(returnType: CustomerDTO.self, url: Firebase.customer) { (result) in
            completion(result)
        }
    }

    func putCustomer(customer: CustomerDTO?, completion: @escaping (Bool) -> Void) {
        guard let customer = customer, let id = customer.userId else { completion(false); return }
        dataControl.putData(objectToUpdate: customer, objectId: id, url: Firebase.customer) { (succes) in
            completion(succes)
        }
    }
}
