//
//  RacketDAOProtocol.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 24/10/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

protocol RacketDAOProtocol {
    func getRacket(racketId: String, completion: @escaping (Racket?) -> Void)
    func putRacket(racket: Racket, completion: @escaping (Bool) -> Void)
    func putTempRacket(racket: Racket, completion: @escaping (Bool) -> Void)
}
