//
//  SignupController.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 08/08/2022.
//

import UIKit

class SignupController: UIViewController {

    // MARK: Variabel
    let colorApp = ColorAppModel()



    // MARK: Outlet
    @IBOutlet weak private var inputPhoneView: UIView!
    @IBOutlet weak private var inputTextField: UITextField!
    @IBOutlet weak private var nextButton: UIButton!

    @IBOutlet weak private var contactPhoneView: UIView!

    @IBOutlet weak private var hotlineLbl: UIButton!
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        config()

    }
    // MARK: Config

    func config() {
        configInputview(flag: false)
        configNextButton()
        updateNextButtonForEnabed(stateOfButton: false)
        configInputTxf()
        configContactPhoneView()
    }


    func configContactPhoneView() {
        contactPhoneView.layer.cornerRadius = 24
        contactPhoneView.layer.backgroundColor = UIColor(red: 0.055, green: 0.678, blue: 0.412, alpha: 0.05).cgColor
    }

    func configInputview(flag: Bool) {
        inputPhoneView.layer.cornerRadius = 24
        inputPhoneView.layer.borderWidth = 2
        inputPhoneView.layer.borderColor = flag ? colorApp.buttonPrimaryColor.cgColor :         colorApp.boderDisbaleColor.cgColor
    }

    func configNextButton() {
        nextButton.layer.cornerRadius = 24
        nextButton.titleLabel?.textColor = .white

    }

    func configInputTxf() {
        inputTextField.attributedPlaceholder = NSAttributedString(
            string: "Nhập số điện thoại",
            attributes: [NSAttributedString.Key.foregroundColor: colorApp.grayCustomColor]
        )
    }

    func updateNextButtonForEnabed(stateOfButton: Bool) {
        nextButton.isUserInteractionEnabled = stateOfButton
        nextButton.backgroundColor = stateOfButton ? colorApp.buttonPrimaryColor : colorApp.buttonSecondColor
        nextButton.titleLabel?.textColor = .white

    }


    // MARK: Action
    @IBAction func nextButtonDidTap(_ sender: Any) {

    }

    @IBAction func popBntDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func inpuTextFileChanged(_ sender: Any) {
        configInputview(flag: true)
        let isInputAccepted: Bool = checkInputTextField(valueOfTextField: inputTextField.text)
        updateNextButtonForEnabed(stateOfButton: isInputAccepted)

    }
    // MARK: Logic Function
    func checkInputTextField (valueOfTextField: String?) -> Bool {

        if let valueOfTextField = valueOfTextField {
            if valueOfTextField.first == "0" && valueOfTextField.count >= 10 {
                return true
            }
            if valueOfTextField.first != "0" && valueOfTextField.count >= 9 {
                return true
            }
            return false
        }

        return false
    }




}
