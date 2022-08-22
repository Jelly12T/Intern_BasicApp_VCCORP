//
//  HomeCellModel.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 16/08/2022.
//

import Foundation

struct HomeCellModel {
    var article: Article?
    var promotion: Promotion?
    var doctor: Doctor?
    init(article: Article? , promotion: Promotion?, doctor: Doctor?) {
        self.article = article
        self.promotion = promotion
        self.doctor = doctor
    }

    func getArticle() -> Article? {
        return self.article
    }

    func getPromotion() -> Promotion? {
        return self.promotion
    }

    func getDoctor() -> Doctor? {
        return self.doctor
    }
}

