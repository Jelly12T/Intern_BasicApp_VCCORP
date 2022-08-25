//
//  StringExtension.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 23/08/2022.
//

import Foundation

extension String {
    func isPhoneNumberInVN() -> Bool {
        let regexPhone =  "(\\ |086|098|097|096|032|033|034|035|036|037|038|039|089|090|093|070|079|077|076|078|088|091|094|083|084|085|081|082|092|056|058|099|059)+([0-9]{7})"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", regexPhone)
        print("self \(self)")
        return phoneTest.evaluate(with: self)
    }
}
