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
    var listDoctor: [Doctor] = []

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
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
                if let dic = json?["data"] {
                    if let lisItem = dic["items"] as? [AnyObject]{
                        for item in lisItem {
                            let element =  Doctor(json: item as! [String : AnyObject])
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

