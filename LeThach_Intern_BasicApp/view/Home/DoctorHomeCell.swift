//
//  DoctorHomeCell.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 18/08/2022.
//

import UIKit

class DoctorHomeCell: UICollectionViewCell {

    let colorApp = ColorAppModel()

    // MARK: Outlet
    @IBOutlet weak private var bgView: UIView!
    @IBOutlet weak private var pointLbl: UILabel!
    @IBOutlet weak private var departmentLbl: UILabel!
    @IBOutlet weak private var thumbnailDoctor: UIImageView!
    @IBOutlet weak private var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        self.thumbnailDoctor.image = UIImage(named: "backgroundDoctor")
        //self.image.layer.cornerRadius = 8

    }

    func config() {
        self.thumbnailDoctor.layer.cornerRadius = 8
        self.bgView.layer.borderWidth = 1
        self.bgView.layer.borderColor = UIColor(red: 0.933, green: 0.937, blue: 0.957, alpha: 1).cgColor
        self.bgView.layer.cornerRadius = 8

    }

    //MARK: bind data
    func binData(model: DoctorModel) {
      //  config()
        if model.urlThumbnailDoctor.count == 0 {
            self.thumbnailDoctor.image = UIImage(named: "backgroundDoctor")
        }
        else {
            self.thumbnailDoctor.loadImageFromUrl(urlString: model.urlThumbnailDoctor)
        }
        self.departmentLbl.text = model.department
        self.nameLbl.text = model.name
        let star = model.star
        let numberOfStart = " (\(model.numberOfStar))"

        let styleStar = [NSAttributedString.Key.font : UIFont(name: "NunitoSans-Regular", size: 11)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        let styleNumberOfStar = [NSAttributedString.Key.font : UIFont(name: "NunitoSans-Regular", size: 11)!, NSAttributedString.Key.foregroundColor : colorApp.grayCustomColor ]
        let starLbl = NSMutableAttributedString(string: star, attributes: styleStar)
        let numberOfStartLbl = NSMutableAttributedString(string: numberOfStart, attributes: styleNumberOfStar)
        starLbl.append(numberOfStartLbl)
        pointLbl.attributedText =  starLbl

    }

}
