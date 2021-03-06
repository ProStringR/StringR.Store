//
//  UpdateStorageDelegate.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 21/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol UpdateStorageDelegate: class {
    func removeString(string: RacketString?)
    func addString(string: RacketString?)
    func closeAction()
}
