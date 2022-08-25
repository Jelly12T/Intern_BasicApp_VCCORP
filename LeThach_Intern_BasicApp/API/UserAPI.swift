//
//  UserAPI.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 23/08/2022.
//

import Foundation

protocol UserAPIDelegate: AnyObject {
    func loadingDone(userAPI: UserAPI)
}


class UserAPI {

    var user: User?
    var local: Local?
    weak var delegate: UserAPIDelegate?


    func loadData() {
        let session = URLSession.shared
        guard let url = URL(string: AppAPI.userAPI) else {
            return
        }

        let task = session.dataTask(with: url, completionHandler: { data, response, errors in
            if errors != nil {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
                if let dic = json?["data"]  as? [String : AnyObject]{
                    let item = User(json: dic)
                    self.user = item
                    self.loadLocal(provinceCode: self.user?.provinceCode, districtCode: self.user?.districtCode, wardCode: self.user?.wardCode)
                }


            }
            catch {
                print("erro New api:   " , error)
            }

        })

        task.resume()

    }

    func loadLocal(provinceCode: String?, districtCode: String? ,wardCode: String?) {
        let session = URLSession.shared
        let urlString = "\(AppAPI.localAPI)province_code=\(provinceCode ?? "")&district_code=\(districtCode ?? "")&ward_code=\(wardCode ?? "")"
        guard let url = URL(string: urlString) else {
            return
        }

        let task = session.dataTask(with: url, completionHandler: { data, response, errors in
            if errors != nil {
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
                if let dic = json?["data"]  as? [String : AnyObject]{
                    let item = Local(json: dic)
                    self.local = item
                }
                self.delegate?.loadingDone(userAPI: self)
            }
            catch {
                print("erro New api:   " , error)
            }

        })
        task.resume()
    }


}
