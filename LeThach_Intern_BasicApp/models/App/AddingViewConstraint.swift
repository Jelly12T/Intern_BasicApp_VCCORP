//
//  AddingViewConstraint.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 25/08/2022.
//

import Foundation

import UIKit

class AddingViewConstraint {
    var leftConstraint: NSLayoutConstraint!
    var rightConstraint: NSLayoutConstraint!
    var bottomConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!

    func active() {
        leftConstraint.isActive = true
        rightConstraint.isActive = true
        bottomConstraint.isActive = true
        heightConstraint.isActive = true
    }

    func deactive() {
        leftConstraint.isActive = false
        rightConstraint.isActive = false
        bottomConstraint.isActive = false
        heightConstraint.isActive = false
    }
}
