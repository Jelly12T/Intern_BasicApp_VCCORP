//
//  HomeAPI.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 15/08/2022.
//

import Foundation
import UIKit
protocol HomeAPIDelegate: AnyObject {
    func loadingDone(homeAPI: HomeAPI , islLoading: Bool)
}

class HomeAPI {

    var homeModel: HomeModel = HomeModel()
    var isLoading: Bool = false
    weak var delegate: HomeAPIDelegate?
    // MARK: Load data
    func loadData() {
        let session = URLSession.shared
        guard let url = URL(string: AppAPI.homeAPI) else {
            return
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, errors in

            // check errors
            if errors != nil {
                print("erros in load api HOME")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String : AnyObject]
                self.homeModel.status = json["status"] as? Int
                self.homeModel.message = json["message"] as! String?
                var articleList: [ArticleList] = []
                var doctorList: [DoctorList] = []
                var promotionList: [PromotionList] = []

                for (key, value) in json["data"] as! [String: [AnyObject]] {
                    switch key {
                    case "promotionList" :
                        for item in value {
                            let promotion = PromotionList(id: item["id"] as! Int,
                                                          categoryID: item["category_id"] as! Int,
                                                          code: item["code"] as! String,
                                                          name: item["name"] as! String,
                                                          slug: item["slug"] as! String,
                                                          content: item["content"] as! String,
                                                          picture: item["picture"] as! String,
                                                          fromDate: item["from_date"] as! String,
                                                          toDate: item["to_date"] as! String,
                                                          amount: item["amount"] as! Int,
                                                          type: item["type"] as! Int,
                                                          kind: item["kind"] as! Int,
                                                          createdAt: item["created_at"] as! String,
                                                          categoryName: item["category_name"] as! String,
                                                          amountText: item["amount_text"] as! String,
                                                          link: item["link"] as! String,
                                                          isBookmark: (item["is_bookmark"] != nil))
                            promotionList.append(promotion)
                        }
                    case "doctorList":
                        for item in value {
                            let doctor = DoctorList(id: item["id"] as! Int,
                                                    fullName: item["full_name"] as! String,
                                                    name: item["name"] as! String,
                                                    lastName: item["last_name"] as! String,
                                                    contactEmail: item["contact_email"] as! String,
                                                    phone: item["phone"] as! String,
                                                    avatar: item["avatar"] as! String,
                                                    majorsName: item["majors_name"] as! String,
                                                    ratioStar: item["ratio_star"] as! Double,
                                                    numberOfReviews: item["number_of_reviews"] as! Int,
                                                    numberOfStars: item["number_of_stars"] as! Int )
                            doctorList.append(doctor)

                        }
                    case "articleList":
                        for item in value {
                            let article = ArticleList(id: item["id"] as! Int,
                                                      categoryID: item["category_id"] as! Int,
                                                      title: item["title"] as! String,
                                                      slug: item["slug"] as! String,
                                                      picture: item["picture"] as! String,
                                                      pictureCaption: item["picture_caption"] as! String,
                                                      createdAt: item["created_at"] as! String,
                                                      categoryName: item["category_name"] as! String,
                                                      link: item["link"] as! String )
                            articleList.append(article)
                        }
                    default:
                        break
                    }
                }
                self.homeModel.data = HomeData(articleList: articleList, promotionList: promotionList, doctorList: doctorList)
                self.isLoading = true
                self.delegate?.loadingDone(homeAPI: self, islLoading: self.isLoading)
                print("đã load data xog")
                
            } catch {
               print("errors")
            }

        })
        task.resume()
    }



}
