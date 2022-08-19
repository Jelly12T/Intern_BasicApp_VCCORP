//
//  DoctorAPI.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 19/08/2022.
//

import Foundation

protocol DoctorAPIDelegate: AnyObject {
    func loadingDone(doctorAPI: DoctorAPI)
}



class DoctorAPI {
    var listDoctor: [DoctorList] = []

    weak var delegate: DoctorAPIDelegate?
    func loadData() {
        print("load Doctor api")
        let session = URLSession.shared
        guard let url = URL(string: AppAPI.doctorAPI) else {
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
                            let element =  DoctorList(id: item["id"] as! Int,
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
                            self.listDoctor.append(element)
                        }
                    }
                }
                print("done API doctor   ", self.listDoctor.count )
                self.delegate?.loadingDone(doctorAPI: self)
            }
            catch {
                print("erro New api:   " , error)
            }

        })
        task.resume()
    }

}

