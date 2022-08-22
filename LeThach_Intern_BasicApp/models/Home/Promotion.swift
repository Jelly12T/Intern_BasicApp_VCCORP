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


    convenience init(json: [String : AnyObject]) {
        self.init()
        if let value = json["amount"] as? Int {
            self.amount = value
        }
        if let value = json["amount_text"] as? String {
            self.amountText = value
        }
        if let value = json["category_id"] as? Int {
            self.categoryID = value
        }
        if let value = json["category_name"] as? String {
            self.categoryName = value
        }
        if let value = json["code"] as? String {
            self.code = value
        }
        if let value = json["content"] as? String {
            self.content = value
        }
        if let value = json["created_at"] as? String {
            self.createdAt = value
        }
        if let value = json["from_date"] as? String {
            self.fromDate = value
        }
        if let value = json["id"] as? Int {
            self.id = value
        }
        if let value = json["is_bookmark"] as? Bool {
            self.isBookmark = value
        }
        if let value = json["kind"] as? Int {
            self.kind = value
        }
        if let value = json["link"] as? String {
            self.link = value
        }
        if let value = json["name"] as? String {
            self.name = value
        }
        if let value = json["picture"] as? String {
            self.picture = value
        }
        if let value = json["slug"] as? String {
            self.slug = value
        }
        if let value = json["to_date"] as? String {
            self.toDate = value
        }
        if let value = json["type"] as? Int {
            self.type = value
        }
    }
}
