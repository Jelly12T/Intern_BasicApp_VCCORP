//
//  UserInfoModel.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 19/08/2022.
//

import Foundation

struct UserInfoModel {
    var nameCell: String
    var valueInTxf: String
    var isStar: Bool
    init(nameCell: String, valueInTxf: String, isStar: Bool ){
        self.nameCell = nameCell
        self.valueInTxf = valueInTxf
        self.isStar = isStar
    }
}
