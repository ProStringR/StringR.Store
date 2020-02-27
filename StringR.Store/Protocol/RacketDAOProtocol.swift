//
//  RacketDAOProtocol.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 24/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol RacketDAOProtocol {
    func getRacket(racketId: String, completion: @escaping (RacketFb?) -> Void)
    func putRacket(racket: RacketFb, completion: @escaping (Bool) -> Void)
    func putTempRacket(racket: RacketFb, completion: @escaping (Bool) -> Void)
}
