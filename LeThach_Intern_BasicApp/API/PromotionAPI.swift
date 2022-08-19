//
//  PromotionAPI.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 18/08/2022.
//

import Foundation
protocol PromotionAPIDelegate: AnyObject {
    func loadingDone(promotionAPI: PromotionAPI)
}

class PromotionAPI {
    var listPromotion: [PromotionList] = []
    weak var delegate: PromotionAPIDelegate?
    func loadData() {
        print("load promotion api")
        let session = URLSession.shared
        guard let url = URL(string: AppAPI.promotionAPI) else {
            return
        }

        let task = session.dataTask(with: url, completionHandler: { data, response, errors in
            if errors != nil {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String : AnyObject]
                if let dic = json["data"] {
                    if let lisItem = dic["items"] as? [AnyObject]{
                        for item in lisItem {
                            let element = PromotionList(id: item["id"] as! Int,
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
                            self.listPromotion.append(element)
                        }
                    }
                }
                print("done API promotion   ", self.listPromotion.count )
                self.delegate?.loadingDone(promotionAPI: self)
            }
            catch {
                print("erro New api:   " , error)
            }

        })
        task.resume()
    }

}
