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
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
                self.homeModel.status = json?["status"] as? Int
                self.homeModel.message = json?["message"] as? String
                var listArticle: [Article] = []
                var listDoctor: [Doctor] = []
                var listPromotion: [Promotion] = []
           
                for (key, value) in json!["data"] as! [String: [AnyObject]] {
                    print(key)
                    var cnt: Int = 0
                    switch key {
                    case "promotionList" :
                        for item in value {
                            cnt += 1
                            let item = Promotion(json: item as! [String : AnyObject])
                            listPromotion.append(item )
                        }
                    case "doctorList":
                        for item in value {
                            let doctor = Doctor(id: item["id"] as? Int,
                                                    fullName: item["full_name"] as? String,
                                                    name: item["name"] as? String,
                                                    lastName: item["last_name"] as? String,
                                                    contactEmail: item["contact_email"] as? String,
                                                    phone: item["phone"] as? String,
                                                    avatar: item["avatar"] as? String,
                                                    majorsName: item["majors_name"] as? String,
                                                    ratioStar: item["ratio_star"] as? Double,
                                                    numberOfReviews: item["number_of_reviews"] as? Int,
                                                    numberOfStars: item["number_of_stars"] as? Int )
                            listDoctor.append(doctor)

                        }
                    case "articleList":
                        for item in value {
                            let article = Article(id: item["id"] as? Int,
                                                      categoryID: item["category_id"] as? Int,
                                                      title: item["title"] as? String,
                                                      slug: item["slug"] as? String,
                                                      picture: item["picture"] as? String,
                                                      pictureCaption: item["picture_caption"] as? String,
                                                      createdAt: item["created_at"] as? String,
                                                      categoryName: item["category_name"] as? String,
                                                      link: item["link"] as? String )
                            listArticle.append(article)
                        }
                    default:
                        break
                    }
                }
                self.homeModel.data = HomeData(ListArticle: listArticle , ListPromotion: listPromotion, ListDoctor: listDoctor)
                self.isLoading = true
                self.delegate?.loadingDone(homeAPI: self, islLoading: self.isLoading)
                print("đã load data xog")
                print(listArticle.count, listPromotion.count, listDoctor.count)
                
            } catch {
               print("errors")
            }

        })
        task.resume()
    }



}
