//
//  Local.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 23/08/2022.
//

import Foundation

class Local {
    var provinceName, districtName, wardName: String?

    init(provinceName: String?, districtName: String?, wardName: String?) {
            self.provinceName = provinceName
            self.districtName = districtName
            self.wardName = wardName
    }

    convenience init(json: [String : AnyObject]) {
        self.init(provinceName: nil, districtName: nil, wardName: nil )
        if let value = json["province_name"] as? String{
            self.provinceName = value
        }

        if let value = json["district_name"] as? String {
            self.districtName = value
        }

        if let value = json["ward_name"] as? String {
            self.wardName = value
        }
    }
}
