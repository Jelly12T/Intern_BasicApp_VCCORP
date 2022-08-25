//
//  Promotion.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 15/08/2022.
//

import Foundation

class Promotion: Codable {
    var id, categoryID: Int?
    var code, name, slug, content: String?
    var picture: String?
    var fromDate, toDate: String?
    var amount, type, kind: Int?
    var createdAt, categoryName, amountText: String?
    var link: String?
    var isBookmark: Bool?

    init(id: Int?, categoryID: Int?, code: String?, name: String?, slug: String?, content: String?, picture: String?, fromDate: String?, toDate: String?, amount: Int?, type: Int?, kind: Int?, createdAt: String?, categoryName: String?, amountText: String?, link: String?, isBookmark: Bool?) {
           self.id = id
           self.categoryID = categoryID
           self.code = code
           self.name = name
           self.slug = slug
           self.content = content
           self.picture = picture
           self.fromDate = fromDate
           self.toDate = toDate
           self.amount = amount
           self.type = type
           self.kind = kind
           self.createdAt = createdAt
           self.categoryName = categoryName
           self.amountText = amountText
           self.link = link
           self.isBookmark = isBookmark
       }


    convenience init(json: [String : AnyObject]) {
        self.init(id: nil, categoryID: nil, code: nil, name: nil, slug: nil, content: nil, picture: nil, fromDate: nil, toDate: nil, amount: nil, type: nil, kind: nil, createdAt: nil, categoryName: nil, amountText: nil, link: nil, isBookmark: nil)
        
        if let wrapValue = json["amount"] as? Int {
            self.amount = wrapValue
        }
        if let wrapValue = json["amount_text"] as? String {
            self.amountText = wrapValue
        }
        if let wrapValue = json["category_id"] as? Int {
            self.categoryID = wrapValue
        }
        if let wrapValue = json["category_name"] as? String {
            self.categoryName = wrapValue
        }
        if let wrapValue = json["code"] as? String {
            self.code = wrapValue
        }
        if let wrapValue = json["content"] as? String {
            self.content = wrapValue
        }
        if let wrapValue = json["created_at"] as? String {
            self.createdAt = wrapValue
        }
        if let wrapValue = json["from_date"] as? String {
            self.fromDate = wrapValue
        }
        if let wrapValue = json["id"] as? Int {
            self.id = wrapValue
        }
        if let wrapValue = json["is_bookmark"] as? Bool {
            self.isBookmark = wrapValue
        }
        if let wrapValue = json["kind"] as? Int {
            self.kind = wrapValue
        }
        if let wrapValue = json["link"] as? String {
            self.link = wrapValue
        }
        if let wrapValue = json["name"] as? String {
            self.name = wrapValue
        }
        if let wrapValue = json["picture"] as? String {
            self.picture = wrapValue
        }
        if let wrapValue = json["slug"] as? String {
            self.slug = wrapValue
        }
        if let wrapValue = json["to_date"] as? String {
            self.toDate = wrapValue
        }
        if let wrapValue = json["type"] as? Int {
            self.type = wrapValue
        }
    }
}
