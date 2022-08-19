//
//  DoctorModel.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 18/08/2022.
//

import Foundation
import UIKit

struct DoctorModel {
    var urlThumbnailDoctor: String
    var name: String
    var department: String
    var star: String
    var numberOfStar: String
    init(urlThumbnailDoctor: String , name: String, department: String, star: String , numberOfStar: String){
        self.urlThumbnailDoctor = urlThumbnailDoctor
        self.name = name
        self.department = department
        self.star = star
        self.numberOfStar = numberOfStar
    }
}
