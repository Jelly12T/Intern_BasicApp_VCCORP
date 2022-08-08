//
//  SlideInfo.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 05/08/2022.
//

import Foundation

struct SlideInfo {
    var nameImage: String!
    var title: String!
    var subTitle: String!
    init(nameImage: String , title: String , subTitle: String) {
        self.nameImage = nameImage
        self.title = title
        self.subTitle = subTitle
    }
}
