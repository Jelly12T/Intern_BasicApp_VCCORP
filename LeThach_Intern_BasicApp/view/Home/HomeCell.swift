//
//  HomeCell.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 15/08/2022.
//

import UIKit

protocol HomeCellDetegate: AnyObject {
    func getToURLDetai(model: HomeCell, url: String)
}

class HomeCell: UICollectionViewCell {

    private var urlDetail: String = ""
    weak var delegate: HomeCellDetegate?

    // MARK: Outlet
    @IBOutlet weak private var dotView: UIView!
    @IBOutlet weak private var dateLbl: UILabel!
    @IBOutlet weak private var titleLbl: UILabel!
    @IBOutlet weak private var image: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var detailBnt: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: clear cell
    override func prepareForReuse() {
        self.image.image = UIImage(named: "backgroundDoctor")
        //self.image.layer.cornerRadius = 8

    }


    func configDotView() {
        self.dotView.roundCorners(corners: [.topLeft, .topRight , .bottomLeft , .bottomRight], radius: 16)
        self.image.roundCorners(corners: [.topLeft, .topRight , .bottomLeft , .bottomRight], radius: 8)
        self.bgView.layer.borderWidth = 1
        self.bgView.layer.borderColor = UIColor(red: 0.933, green: 0.937, blue: 0.957, alpha: 1).cgColor
        self.bgView.layer.cornerRadius = 8

    }




    // if typeOfCell == 1 -> article
    // if typeOfCell == 2 -> promotion
    func bindData(homeCellModel: HomeCellModel , typeOfCell: Int){
        configDotView()
        self.detailBnt.addTarget(self, action: #selector(self.detailBntDidTap), for: .touchUpInside)
        switch typeOfCell {
        case 1:
            self.urlDetail = homeCellModel.article!.link
            self.image.loadImageFromUrl(urlString: homeCellModel.article!.picture)
            self.dateLbl.text = homeCellModel.article!.createdAt
            self.titleLbl.text = homeCellModel.article!.title
            
        case 2:
            self.urlDetail = homeCellModel.promotion!.link
            self.image.loadImageFromUrl(urlString: homeCellModel.promotion!.picture)
            self.dateLbl.text = homeCellModel.promotion!.createdAt
            self.titleLbl.text = homeCellModel.promotion!.name
        default:
            break
        }
    }

     @objc func detailBntDidTap() {
         self.delegate?.getToURLDetai(model: self, url: self.urlDetail)
    }
    

}
