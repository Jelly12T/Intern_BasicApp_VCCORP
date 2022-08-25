//
//  NewCell.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 18/08/2022.
//

import UIKit

class NewCell: UICollectionViewCell {

    var isSaved: Bool = false
    var colorApp = ColorAppModel()

    //MARK: Outlet
    @IBOutlet weak private var lineBottomView: UIView!
    @IBOutlet weak private var lineTopView: UIView!
    @IBOutlet weak private var titleLbl: UILabel!
    @IBOutlet weak private var dateLbl: UILabel!
    @IBOutlet weak private var thumbnailNewCell: UIImageView!
    @IBOutlet weak private var saveBnt: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        self.thumbnailNewCell.image = UIImage(named: "backgroundDoctor")
        //self.image.layer.cornerRadius = 8

    }


    // MARK: bind
    // i
    func bindData(model: NewModel, isHiddenLineTop: Bool) {
        if model.urlImage.count == 0 {
            self.thumbnailNewCell.image = UIImage(named: "backgroundDoctor")
        }
        else {
            self.thumbnailNewCell.loadImageFromUrl(urlString: model.urlImage)
        }


        lineTopView.isHidden = isHiddenLineTop
        lineBottomView.isHidden = !isHiddenLineTop

        self.titleLbl.text = model.title
        self.dateLbl.text = self.convertDate(date: model.creatAt)


    }

    func convertDate(date: String?) -> String {
        if (date ?? "").count == 0 {
            return "Không có"
        }

        var res: String = ""
        var temp: String = ""
        var cnt: Int = 0
        for element in date! {
            if element == "/" {
                cnt += 1
                res.append(temp)
                temp = ""
                if cnt == 1 {
                    res.append(" tháng ")
                    continue
                }

                res.append(", ")
                continue
            }
            temp.append(element)
        }

        if temp.count > 0 {
            res.append(temp)
        }
        return res
    }

    func updateSaveBnt(){
        if self.isSaved {
            self.saveBnt.setImage(UIImage(named: "save"), for: .normal)
            return
        }
        self.saveBnt.setImage(UIImage(named: "noSave"), for: .normal)
    }

    // MARK: action
    @IBAction func saveBnt(_ sender: Any) {

        self.isSaved = !self.isSaved
        updateSaveBnt()

    }

}
