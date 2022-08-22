//
//  UserInforCell.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 19/08/2022.
//

import UIKit

class UserInforCell: UICollectionViewCell {

    var isFocusing: Bool = false
    var colorApp = ColorAppModel()

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var userTxf: UITextField!
    @IBOutlet weak var nameCellLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindData(model: UserInfoModel) {
        self.userTxf.text = model.valueInTxf
        self.nameCellLbl.text = (model.isStar ? "\(model.nameCell)*" : model.nameCell)
        config()
    }

    func config() {
        self.nameCellLbl.textColor = self.isFocusing ? colorApp.buttonPrimaryColor : colorApp.lblDisbale
        self.lineView.backgroundColor = self.isFocusing ? colorApp.buttonPrimaryColor : colorApp.lblDisbale

    }

}
