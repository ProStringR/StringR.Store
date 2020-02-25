//
//  Utility.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 14/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class Utility {

    static func getString(forKey key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }

    static func getString(forKey key: String, withArgs args: [String]) -> String {
        let string = NSLocalizedString(key, comment: "")
        return String(format: string, arguments: args)
    }

    static func getUUID() -> String {
        return NSUUID().uuidString
    }

    static func readPrimitiveFromSharedPref(_ key: String) -> Any {

        let defaults = UserDefaults.standard
        if let primitiveToReturn = defaults.string(forKey: key) {
            return primitiveToReturn
        } else {
            return Constant.emptyString
        }
    }

    static func writePrimitiveToSharedPref(withKey key: String, value primitive: Any) {
        let defaults = UserDefaults.standard
        defaults.set(primitive, forKey: key)
    }

    static func deletePrimitiveFromSharedPref(withKey key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }

    static func dateToString(date: Date, withTime: Bool = true) -> String {
        if withTime {
            return date.toString(dateFormat: "dd/MM/yyyy | HH:mm")
        }

        return date.toString(dateFormat: "dd/MM/yyyy")
    }

    static func getLastChars(string: String, amount: Int) -> String {
        return String(string.suffix(amount))
    }
}
