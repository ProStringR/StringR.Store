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

    static func readStringFromSharedPref(_ key: String) -> String {

        let defaults = UserDefaults.standard
        if let stringToReturn = defaults.string(forKey: key) {
            return stringToReturn
        } else {
            return Constant.emptyString
        }
    }

    static func writeStringToSharedPref(withKey key: String, value string: String) {
        let defaults = UserDefaults.standard
        defaults.set(string, forKey: key)
    }

    static func deleteStringFromSharedPref(withKey key: String) {
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

    static func fetchStaticData() {
        StringColorSingleton.shared.fetchData()
        PurposeSingleton.shared.fetchData()
        RacketBrandSingleton.shared.fetchData()
        StringBrandSingleton.shared.fetchData()
        StringTypeSingleton.shared.fetchData()
    }
}
