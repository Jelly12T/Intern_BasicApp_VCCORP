//
//  Doctor.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 15/08/2022.
//

import Foundation

class Doctor {
    var id: Int?
    var fullName, name, lastName, contactEmail: String?
    var phone: String?
    var avatar: String?
    var majorsName: String?
    var ratioStar: Double?
    var numberOfReviews, numberOfStars: Int?

    
    init(id: Int?, fullName: String?, name: String?, lastName: String?, contactEmail: String?, phone: String?, avatar: String?, majorsName: String?, ratioStar: Double?, numberOfReviews: Int?, numberOfStars: Int?) {
            self.id = id
            self.fullName = fullName
            self.name = name
            self.lastName = lastName
            self.contactEmail = contactEmail
            self.phone = phone
            self.avatar = avatar
            self.majorsName = majorsName
            self.ratioStar = ratioStar
            self.numberOfReviews = numberOfReviews
            self.numberOfStars = numberOfStars
        }


    convenience init(json: [String : AnyObject]) {
        self.init(id: nil, fullName: nil, name: nil, lastName: nil , contactEmail: nil, phone: nil, avatar: nil, majorsName: nil, ratioStar: nil, numberOfReviews: nil, numberOfStars: nil)

        if let value = json["avatar"] as? String {
            self.avatar = value
        }
        if let value = json["contact_email"] as? String {
            self.contactEmail = value
        }
        if let value = json["full_name"] as? String {
            self.fullName = value
        }
        if let value = json["id"] as? Int {
            self.id = value
        }
        if let value = json["last_name"] as? String {
            self.lastName = value
        }
        if let value = json["majors_name"] as? String {
            self.majorsName = value
        }
        if let value = json["name"] as? String {
            self.name = value
        }
        if let value = json["number_of_reviews"] as? Int {
            self.numberOfReviews = value
        }
        if let value = json["number_of_stars"] as? Int {
            self.numberOfStars = value
        }
        if let value = json["phone"] as? String {
            self.phone = value
        }
        if let value = json["ratio_star"] as? Double {
            self.ratioStar = value
        }

    }
}
