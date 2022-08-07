//
//  SlideInforCell.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 05/08/2022.
//

import UIKit

class SlideInforCell: UICollectionViewCell {

    let width = UIScreen.main.bounds.size.width
    let heigth = UIScreen.main.bounds.size.height


    // MARK: Outluet
    @IBOutlet weak private var slideInfoCellImageView: UIImageView!
    @IBOutlet weak private var slideInforTitleLabel: UILabel!
    @IBOutlet weak private var slideInForSubtitleLabel: UILabel!

    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        print("cell size", width, heigth)
        // Initialization code
    }

    // MARK: Bind data
    func bind (model: SlideInfo) {
        self.slideInfoCellImageView.image = UIImage(named: model.nameImage)
        self.slideInforTitleLabel.text = model.title
        self.slideInForSubtitleLabel.text = model.subTitle
    }

}
