//
//  RemoveStringerDelegate.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 09/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol RemoveStringerDelegate: class {
    func removeStringer(stringer: StringerREST)
    func closeAction()
}
