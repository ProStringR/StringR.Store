//
//  StringColorSingleton.swift
//  StringR.Store
//
//  Created by Jaafar Mahdi on 28/02/2020.
//  Copyright © 2020 StringR. All rights reserved.
//

import Foundation

class StringColorSingleton {
    let staticDataController = ControlReg.getStaticDataController

    static let shared = StringColorSingleton()

    var colors: [StringColorREST]?

    private init() { }

    func fetchData() {
        if colors == nil {
            staticDataController.getAllColors { (colors) in
                if let colors = colors {
                    self.colors = colors
                }
            }
        }
    }

    func getAllColors(completion: @escaping ([StringColorREST]?) -> Void) {
        if let colors = self.colors {
            completion(colors)
            return
        }

        staticDataController.getAllColors { (colors) in
            if let colors = colors {
                self.colors = colors
                completion(colors)
            }
        }
    }
}
