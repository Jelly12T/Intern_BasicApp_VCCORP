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
                            let doctor = Doctor(json: item as! [String : AnyObject])
                            listDoctor.append(doctor)

                        }
                    case "articleList":
                        for item in value {
                            let article = Article(json: item as! [String : AnyObject])
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
