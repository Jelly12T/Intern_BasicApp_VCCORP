//
//  AricleModel.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 17/08/2022.
//

import Foundation
import UIKit

struct AricleModel {
    var dateCreatAt: String
    var title: String
    var image: UIImageView
    init(dateCreatAt: String, title: String, image: UIImageView) {
        self.dateCreatAt = dateCreatAt
        self.title = title
        self.image = image
    }
}
