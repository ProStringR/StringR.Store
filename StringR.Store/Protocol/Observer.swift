//
//  Observer.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 19/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol Observer {
    func update(observable: Observerable)
}
