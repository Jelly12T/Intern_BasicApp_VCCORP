//
//  NewsAPI.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 18/08/2022.
//

import Foundation
protocol NewAPIDelegate: AnyObject {
    func loadingDone(newsAPI: NewAPI)
}

class NewAPI {
    var listNews: [Article] = []
    weak var delegate: NewAPIDelegate?


    func loadData() {
        print("load new api")
        let session = URLSession.shared
        guard let url = URL(string: AppAPI.newsAPI) else {
            return
        }

        let task = session.dataTask(with: url, completionHandler: { data, response, errors in
            if errors != nil {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
                if let dic = json!["data"] {
                    if let lisItem = dic["items"] as? [AnyObject]{
                        for item in lisItem {
                            let element = Article(json:  item as! [String : AnyObject] )
                            self.listNews.append(element)
                        }
                    }
                }
                print("done API NEWs")
                self.delegate?.loadingDone(newsAPI: self)
            }
            catch {
                print("erro New api:   " , error)
            }

        })
        task.resume()
    }

}
