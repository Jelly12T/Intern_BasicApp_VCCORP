//
//  HomeCell.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 15/08/2022.
//

import UIKit

class HomeCell: UICollectionViewCell {

    // MARK: Outlet
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak private var dotView: UIView!
    @IBOutlet weak private var dateLbl: UILabel!
    @IBOutlet weak private var titleLbl: UILabel!
    @IBOutlet weak private var image: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: clear cell
    override func prepareForReuse() {
        self.image.image = UIImage(named: "backgroundDoctor")
        config()
    }

    func config() {
        configDotView()
    }
    func configDotView() {
        self.dotView.roundCorners(corners: [ .bottomLeft , .bottomRight], radius: 8)

    }

    func configTextLblView() {
        self.backgroundColor = .clear
    }

    // if typeOfCell == 1 -> article
    // if typeOfCell == 2 -> promotion
    func bindData(homeCellModel: HomeCellModel , typeOfCell: Int){
        config()
        switch typeOfCell {
        case 1:

            self.image.loadImageFromUrl(urlString: homeCellModel.article!.picture ?? "" )
            self.dateLbl.text = homeCellModel.article!.createdAt
            self.titleLbl.text = homeCellModel.article!.title
            
        case 2:
           
            self.image.loadImageFromUrl(urlString: homeCellModel.promotion!.picture!)
            self.dateLbl.text = homeCellModel.promotion!.createdAt
            self.titleLbl.text = homeCellModel.promotion!.name
        default:
            break
        }
    }

}
