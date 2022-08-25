//
//  OptItem.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 11/08/2022.
//

import Foundation
import UIKit

class OtpItemView: UIControl {

    let appColor = ColorAppModel()
    var isFocusing: Bool = false
    var isLock: Bool = false
    var optLbl: UILabel!

    // MARK: init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.config()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.config()

    }

    // MARK: config
    func config() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.configLbl()
        self.buildUI()
    }

    func configLbl() {
        self.optLbl = UILabel()
        self.optLbl.textColor = .black
        self.optLbl.textAlignment = .center
        self.optLbl.text = ""
        self.optLbl.font = UIFont(name: "NunitoSans-SemiBold", size: 20)
    }

    func buildUI() {
        self.addSubview(self.optLbl)
        self.optLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.optLbl.topAnchor.constraint(equalTo: self.topAnchor),
            self.optLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.optLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor),

        ])
    }
    // MARK: action
    func focus() {
        self.isFocusing = true
        self.isLock = false
        self.layer.borderWidth = 1.5
        self.layer.borderColor = appColor.boderFocusColor.cgColor

    }

    func lock() {
        self.isLock = true
        self.isFocusing = false
        self.layer.borderWidth = 0
        self.layer.borderColor = appColor.boderDisbaleColor.cgColor
    }

}
