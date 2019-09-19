//
//  Observable.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 19/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation

class Observerable {

    var observers = [Observer]()

    func attach(observer: Observer) {
        self.observers.append(observer)
    }

    func notifyChange() {
        for observer in self.observers {
            observer.update(observable: self)
        }
    }
}
