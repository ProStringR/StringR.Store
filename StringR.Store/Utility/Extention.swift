//
//  Extention.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 14/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func hideNavigationBar() {
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .white
    }
}

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}

extension Date {
    var millisecondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    func toString( dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }

    func isInSameWeek(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .weekOfYear)
    }

    func isInSameMonth(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .month)
    }

    func isInSameYear(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .year)
    }

    func isInSameDay(date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .day)
    }

    var isInCurrentWeek: Bool {
        return isInSameWeek(date: Date())
    }

    var isInCurrentMonth: Bool {
        return isInSameMonth(date: Date())
    }

    var isInCurrentYear: Bool {
        return isInSameYear(date: Date())
    }

    var isInYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }

    var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }

    var isInTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }

    var isInTheFuture: Bool {
        return Date() < self
    }

    var isInThePast: Bool {
        return self < Date()
    }
}

extension UIViewController {
    func showSpinner(withSpinner spinnerView: UIView) {
        let activityIndicator = UIActivityIndicatorView.init(style: .gray)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center

        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            self.view.addSubview(spinnerView)
            self.navigationController?.tabBarController?.tabBar.isHidden = true
        }
    }

    func removeSpinner(forSpinner spinnerView: UIView) {
        DispatchQueue.main.async {
            spinnerView.removeFromSuperview()
            self.navigationController?.tabBarController?.tabBar.isHidden = false
        }
    }
}
