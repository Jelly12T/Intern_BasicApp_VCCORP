//
//  DoctorCell.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 19/08/2022.
//

import UIKit

class DoctorCell: UICollectionViewCell {


    let colorApp = ColorAppModel()

    // MARK: Outlet
    @IBOutlet weak private var poinOfDoctorLbl: UILabel!
    @IBOutlet weak private var deparmentDoctorLbl: UILabel!
    @IBOutlet weak private var nameDoctorLbl: UILabel!
    @IBOutlet weak private var thumbnailDoctor: UIImageView!
    @IBOutlet weak private var doctorBgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: config

    func configCell() {
        self.doctorBgView.layer.cornerRadius = 12
        self.doctorBgView.layer.borderWidth = 1
        self.doctorBgView.layer.borderColor = colorApp.boderDisbaleColor.cgColor
        self.thumbnailDoctor.layer.cornerRadius = 12

    }

    // MARK: Bind data

    func bindData(model: DoctorModel ){

        configCell()

        if model.urlThumbnailDoctor.count == 0 {
            self.thumbnailDoctor.image = UIImage(named: "backgroundDoctor")
        }
        else {
            self.thumbnailDoctor.loadImageFromUrl(urlString: model.urlThumbnailDoctor)
        }
        self.deparmentDoctorLbl.text = "Chuyên ngành: \(model.department)"
        self.nameDoctorLbl.text = model.name
        let star = model.star
        let numberOfStart = " (\(model.numberOfStar))"

        let styleStar = [NSAttributedString.Key.font : UIFont(name: "NunitoSans-Regular", size: 11)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        let styleNumberOfStar = [NSAttributedString.Key.font : UIFont(name: "NunitoSans-Regular", size: 11)!, NSAttributedString.Key.foregroundColor : colorApp.grayCustomColor ]
        let starLbl = NSMutableAttributedString(string: star, attributes: styleStar)
        let numberOfStartLbl = NSMutableAttributedString(string: numberOfStart, attributes: styleNumberOfStar)
        starLbl.append(numberOfStartLbl)
        poinOfDoctorLbl.attributedText =  starLbl

    }

}
