//
//  Article.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 15/08/2022.
//

import Foundation
struct Article {
    var id, categoryID: Int?
    var title, slug: String?
    var picture: String?
    var pictureCaption, createdAt, categoryName: String?
    var link: String?
    init(id: Int?, categoryID: Int?, title: String?, slug: String?, picture: String?, pictureCaption: String?, createdAt: String?, categoryName: String?, link: String?) {
            self.id = id
            self.categoryID = categoryID
            self.title = title
            self.slug = slug
            self.picture = picture
            self.pictureCaption = pictureCaption
            self.createdAt = createdAt
            self.categoryName = categoryName
            self.link = link
        }

}
