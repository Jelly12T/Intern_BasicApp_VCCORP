//
//  Article.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 15/08/2022.
//

import Foundation
class Article {
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

    convenience init(json: [String : AnyObject]) {
        self.init(id: nil, categoryID: nil, title: nil, slug: nil, picture: nil, pictureCaption: nil, createdAt: nil, categoryName: nil, link: nil)

        if let value = json["category_id"] as? Int {
            self.categoryID = value
        }
        if let value = json["category_name"] as? String {
            self.categoryName = value
        }
        if let value = json["created_at"] as? String {
            self.createdAt = value
        }
        if let value = json["id"] as? Int {
            self.id = value
        }
        if let value = json["link"] as? String {
            self.link = value
        }
        if let value = json["picture"] as? String {
            self.picture = value
        }
        if let value = json["picture_caption"] as? String {
            self.pictureCaption = value
        }
        if let value = json["slug"] as? String {
            self.slug = value
        }
        if let value = json["title"] as? String {
            self.title = value
        }
    }


}
