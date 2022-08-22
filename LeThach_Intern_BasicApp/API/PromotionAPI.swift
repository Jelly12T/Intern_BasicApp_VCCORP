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
    var listPromotion: [Promotion] = []
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
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
                if let dic = json?["data"] {
                    if let lisItem = dic["items"] as? [AnyObject]{
                        for item in lisItem {
                            let element = Promotion(json: item as! [String : AnyObject])
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
