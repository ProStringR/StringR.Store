//
//  Layout.swift
//  StringR.Store
//
//  Created by Marcus Christiansen on 14/09/2019.
//  Copyright © 2019 StringR. All rights reserved.
//

import Foundation
import UIKit

class Layout {

    static func centerVertically(on view: UIView, withParent parentView: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerYAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }

    static func centerHorizontally(on view: UIView, withParent parentView: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }

    static func addTopConstraint(on view: UIView, to anchor: NSLayoutYAxisAnchor, by points: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: anchor, constant: points).isActive = true
    }

    static func addBottomConstraint(on view: UIView, to anchor: NSLayoutYAxisAnchor, by points: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bottomAnchor.constraint(equalTo: anchor, constant: points).isActive = true
    }

    static func addLeadingConstraint(on view: UIView, to anchor: NSLayoutXAxisAnchor, by points: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: anchor, constant: points).isActive = true
    }

    static func addTrailingConstraint(on view: UIView, to anchor: NSLayoutXAxisAnchor, by points: CGFloat) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.trailingAnchor.constraint(equalTo: anchor, constant: points).isActive = true
    }

    static func setupViewNavigationController(forView view: UIViewController, withTitle title: String) {
        view.navigationController?.hideNavigationBar()
        view.navigationController?.navigationBar.prefersLargeTitles = true
        view.title = title
    }
}
