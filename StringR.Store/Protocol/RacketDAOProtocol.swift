//
//  RacketDAOProtocol.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 24/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol RacketDAOProtocol {
    func postRacketString(racketString: RacketStringDto, completion: @escaping (Bool) -> Void)
}
