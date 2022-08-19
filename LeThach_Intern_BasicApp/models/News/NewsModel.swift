//
//  NewsModel.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 18/08/2022.
//

import Foundation

struct NewModel {
    var urlImage: String
    var title: String
    var creatAt: String
    init(urlImage: String , title: String , creatAt: String) {
        self.urlImage = urlImage
        self.title = title
        self.creatAt = creatAt
    }
}
