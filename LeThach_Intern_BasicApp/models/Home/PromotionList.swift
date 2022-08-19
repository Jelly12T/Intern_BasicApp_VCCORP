//
//  PromotionList.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 15/08/2022.
//

import Foundation

struct PromotionList {
    let id, categoryID: Int
    let code, name, slug, content: String
    let picture: String
    let fromDate, toDate: String
    let amount, type, kind: Int
    let createdAt, categoryName, amountText: String
    let link: String
    let isBookmark: Bool
}

