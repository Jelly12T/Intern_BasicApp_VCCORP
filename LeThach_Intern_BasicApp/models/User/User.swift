//
//  User.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 23/08/2022.
//

import Foundation

class User {
    var id: Int?
    var name, lastName, username, contactEmail: String?
    var phone, address: String?
    var birthDate: String?
    var sex: Int?
    var fullAddress, fullName: String?
    var bloodName: String?
    var provinceCode, districtCode, wardCode: String?

    init(id: Int?, name: String?, lastName: String?, username: String?, contactEmail: String?, phone: String?, address: String?, birthDate: String?, sex: Int?, fullAddress: String?, fullName: String?,bloodName: String?, provinceCode: String?, districtCode: String?, wardCode: String? ) {
        self.id = id
        self.name = name
        self.lastName = lastName
        self.username = username
        self.contactEmail = contactEmail
        self.phone = phone
        self.address = address
        self.birthDate = birthDate
        self.sex = sex
        self.fullAddress = fullAddress
        self.fullName = fullName
        self.bloodName = bloodName
        self.provinceCode = provinceCode
        self.districtCode = districtCode
        self.wardCode = wardCode
    }

    convenience init(json: [String: AnyObject]) {
        self.init(id: nil, name: nil, lastName: nil, username: nil, contactEmail: nil, phone: nil, address: nil, birthDate: nil, sex: nil, fullAddress: nil, fullName: nil, bloodName: nil, provinceCode: nil, districtCode: nil, wardCode: nil)

        if let value = json["id"] as? Int{
            self.id = value
        }

        if let value = json["name"] as? String {
            self.name = value
        }

        if let value = json["last_name"] as? String {
            self.lastName = value
        }

        if let value = json["username"] as? String {
            self.username = value
        }

        if let value = json["contact_email"] as? String {
            self.contactEmail = value
        }

        if let value = json["phone"] as? String {
            self.phone = value
        }

        if let value = json["address"] as? String {
            self.address = value
        }

        if let value = json["birth_date"] as? String {
            self.birthDate = value
        }

        if let value = json["sex"] as? Int {
            self.sex = value
        }

        if let value = json["full_address"] as? String {
            self.fullAddress = value
        }

        if let value = json["full_name"] as? String {
            self.fullName = value
        }

        if let value = json["blood_name"] as? String {
            self.bloodName = value
        }

        if let value = json["province_code"] as? String {
            self.provinceCode = value
        }

        if let value = json["district_code"] as? String {
            self.districtCode = value
        }

        if let value = json["ward_code"] as? String {
            self.wardCode = value
        }
    }



}
