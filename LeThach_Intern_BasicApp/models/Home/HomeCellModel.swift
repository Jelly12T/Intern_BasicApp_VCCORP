//
//  HomeCellModel.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 16/08/2022.
//

import Foundation

struct HomeCellModel {
    var article: ArticleList?
    var promotion: PromotionList?
    var doctor: DoctorList?
    init(article: ArticleList? , promotion: PromotionList?, doctor: DoctorList?) {
        self.article = article
        self.promotion = promotion
        self.doctor = doctor
    }

    func getArticle() -> ArticleList? {
        return self.article
    }

    func getPromotion() -> PromotionList? {
        return self.promotion
    }

    func getDoctor() -> DoctorList? {
        return self.doctor
    }
}

