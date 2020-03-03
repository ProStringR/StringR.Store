//
//  OrderRacketStringREST.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 02/03/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation
import UIKit

class OrderRacketStringREST: Codable {
    var id: Int
    var brand: String
    var model: String
    var type: String
    var thickness: String
    var purpose: String
    var color: String

    func getImageIndication() -> UIImage {
        if purpose == RacketType.TENNIS.rawValue {
              return #imageLiteral(resourceName: "tennisball")
        } else if purpose == RacketType.BADMINTON.rawValue {
              return #imageLiteral(resourceName: "shuttlecock")
        } else {
              return #imageLiteral(resourceName: "squashball")
        }
    }
}
