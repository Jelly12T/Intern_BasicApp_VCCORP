//
//  UserController.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 19/08/2022.
//

import UIKit

class UserController: UIViewController {



    var userAPI = UserAPI()
    var pickerView: DatePickerSubview!
    var colorApp = ColorAppModel()
    let pickerViewConstraints = AddingViewConstraint()
    var activityIndicator = UIActivityIndicatorView()
    var isMan: Bool = true
    
    // MARK: outlet

    @IBOutlet weak var userScV: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var genderView: UIView!

    @IBOutlet weak var dateTxf: UITextField!
    @IBOutlet weak var nameTxf: UITextField!
    @IBOutlet weak var surnameTxf : UITextField!
    @IBOutlet weak var phoneTxf : UITextField!
    @IBOutlet weak var emailTxf : UITextField!
    @IBOutlet weak var districtTxf: UITextField!
    @IBOutlet weak var cityTxf: UITextField!
    @IBOutlet weak var addressTxf: UITextField!
    @IBOutlet weak var wardTxf: UITextField!
    @IBOutlet weak var nameBloodTxf: UITextField!



    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var sextLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var surnameLbl: UILabel!


    @IBOutlet weak var nameLineView: UIView!
    @IBOutlet weak var dateLineView: UIView!
    @IBOutlet weak var surenameLineView: UIView!
    @IBOutlet weak var emailLineView: UIView!
    @IBOutlet weak var phoneLineView: UIView!

    @IBOutlet weak var manBnt: UIButton!

    @IBOutlet weak var girlBnt: UIButton!

    //MARK: lifeCyce
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        registerOBS()
        userAPI.delegate = self
        setDelegateTxf()
        config()
        userAPI.loadData()
        
    }


    // MARK: Config
    func config() {
        configActivityIndicatorView()
        confgiLbl()
        configLineView()
        configUserInformation()
        configGenderView()
    }


    func confgiLbl () {
        let listLbl = [nameLbl, surnameLbl, phoneLbl, emailLbl, dateLbl ,sextLbl]
        for lbl in listLbl {
            lbl?.textColor = colorApp.lblDisbale
        }
    }

    func configGenderView() {
        self.genderView.backgroundColor = colorApp.colorBackgroundDisbale
    }

    func setDelegateTxf() {
        phoneTxf.delegate = self
        nameTxf.delegate = self
        surnameTxf.delegate = self
        dateTxf.delegate = self
        emailTxf.delegate = self
    }

    func configActivityIndicatorView() {
        self.userScV.isHidden = true
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        activityIndicator.startAnimating()
        activityIndicator.center = self.view.center
        self.view.addSubview(self.activityIndicator)

    }

    func configUserInformation() {
        let user = userAPI.user
        let local = userAPI.local
        self.nameTxf.text = user?.name
        self.surnameTxf.text = user?.lastName
        self.dateTxf.text = user?.birthDate
        self.phoneTxf.text = user?.phone
        self.emailTxf.text = user?.contactEmail
        self.cityTxf.text = local?.provinceName
        self.wardTxf.text = local?.wardName
        self.districtTxf.text = local?.districtName
        self.addressTxf.text = user?.fullAddress
        self.nameBloodTxf.text = user?.bloodName
        self.isMan = user?.sex == 1 ? true : false
        configManBnt(isSeleced: self.isMan)
        configGirlButton(isSeleced: !self.isMan)

    }

    func configLineView() {
        let listLineView =  [nameLineView, dateLineView, surenameLineView, emailLineView, phoneLineView]
        for lineViewItem in listLineView {
            lineViewItem?.backgroundColor = colorApp.lblDisbale
        }
    }

    func configDatePicker(){
        self.pickerView = Bundle.main.loadNibNamed("DatePickerSubview", owner: self, options: nil)?.first as? DatePickerSubview
        self.view.addSubview(self.pickerView)
        self.pickerView.delegate = self
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerViewConstraints.leftConstraint = self.pickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        pickerViewConstraints.rightConstraint = self.pickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        pickerViewConstraints.bottomConstraint = self.view.bottomAnchor.constraint(equalTo: self.pickerView.bottomAnchor, constant: 8)
        self.dateTxf.inputView = pickerView
        pickerViewConstraints.heightConstraint = self.pickerView.heightAnchor.constraint(equalToConstant: 200)
        pickerViewConstraints.active()

    }

    func registerOBS() {
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: Obj fubc
    @objc func KeyboardWillShow(notification: Notification){

        let window = UIApplication.shared.windows.first
        let bottomPadding = window?.safeAreaInsets.bottom
        var keyboardFrame:CGRect = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0
        UIView.animate(withDuration: duration) {[weak self] in
            guard let self = self else { return}

            var contentInset:UIEdgeInsets = self.userScV.contentInset
            contentInset.bottom = keyboardFrame.size.height + (bottomPadding ?? .zero) - 14
            self.userScV.contentInset = contentInset
        }


    }


    @objc func KeyboardWillHide(notification: Notification) {
        let window = UIApplication.shared.windows.first
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0
        let bottomPadding = window?.safeAreaInsets.bottom
        UIView.animate(withDuration: duration) {[weak self] in
            guard let self = self else { return}
            var contentInset:UIEdgeInsets = UIEdgeInsets.zero
            contentInset.bottom =  (bottomPadding ?? .zero)
            self.userScV.contentInset = contentInset
        }
    }


    func configGirlButton(isSeleced: Bool) {
        updateUITxfSelected(lbl:sextLbl , lineview: nil, state: true)
        dissmissKeyBoard()
        girlBnt.layer.backgroundColor = isSeleced ? UIColor.white.cgColor : UIColor.clear.cgColor
        girlBnt.setTitleColor(isSeleced ? colorApp.buttonPrimaryColor : colorApp.colorLblDisbale2, for: .normal)
        girlBnt.borderWidth = isSeleced ? 1 : 0
        girlBnt.tintColor = isSeleced ? colorApp.buttonPrimaryColor : colorApp.colorLblDisbale2
    }

    func configManBnt(isSeleced: Bool) {
        updateUITxfSelected(lbl:sextLbl , lineview: nil, state: true)
        dissmissKeyBoard()
        manBnt.layer.backgroundColor = isSeleced ? UIColor.white.cgColor :  UIColor.clear.cgColor
        manBnt.setTitleColor(isSeleced ? colorApp.buttonPrimaryColor : colorApp.colorLblDisbale2, for: .normal)
        manBnt.borderWidth = isSeleced ? 1 : 0
        manBnt.tintColor = isSeleced ? colorApp.buttonPrimaryColor : colorApp.colorLblDisbale2
    }


    // MARK: action

    @IBAction func doneBnt(_ sender: Any) {
        self.dissmissKeyBoard()
    }
    @IBAction func backBnt(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func manBntDidTap(_ sender: Any) {
        self.isMan = true
        self.configGirlButton(isSeleced: !self.isMan)
        self.configManBnt(isSeleced: self.isMan)
    }

    @IBAction func girlBntDidTap(_ sender: Any) {
        self.isMan = false
        self.configGirlButton(isSeleced: !self.isMan)
        self.configManBnt(isSeleced: self.isMan)
    }

    // MARK: Update
    func updateUITxfSelected(lbl: UILabel, lineview: UIView?,  state: Bool) {
        let listLbl = [nameLbl, sextLbl, emailLbl, phoneLbl, surnameLbl, dateLbl]
        let listLineView = [nameLineView, dateLineView, surenameLineView, emailLineView, phoneLineView]
        for lblItem in listLbl {
            if lblItem == lbl {
                lblItem?.textColor = state ? colorApp.lblFocus : colorApp.lblDisbale
            }

            if state == true && lblItem != lbl {
                lblItem?.textColor = colorApp.lblDisbale
            }

        }

        for lineViewItem in listLineView {
            if lineViewItem == lineview {
                lineViewItem?.backgroundColor = state ? colorApp.lblFocus : colorApp.lblDisbale
            }

            if state == true && lineViewItem != lineview {
                lineViewItem?.backgroundColor  = colorApp.lblDisbale
            }
        }
    }

    func dissmissKeyBoard() {
        view.endEditing(true)
    }

}


extension UserController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let listTxf = [nameTxf, surnameTxf, phoneTxf, emailTxf , dateTxf]
        for txf in listTxf {
            if txf == textField && txf == nameTxf {
                self.updateUITxfSelected(lbl: nameLbl, lineview: nameLineView, state: true)
                break

            }

            if txf == textField && txf == emailTxf {
                self.updateUITxfSelected(lbl: emailLbl, lineview: emailLineView, state: true)
                break
            }

            if txf == textField && txf == surnameTxf {
                self.updateUITxfSelected(lbl: surnameLbl, lineview: surenameLineView, state: true)
                break
            }

            if txf == textField && txf == phoneTxf {
                self.updateUITxfSelected(lbl: phoneLbl, lineview: phoneLineView, state: true)

                break
            }

            if txf == textField && txf == dateTxf {
                configDatePicker()
                self.updateUITxfSelected(lbl: dateLbl, lineview: dateLineView, state: true)
                break
            }


        }
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let listLbl = [nameLbl, sextLbl, emailLbl, phoneLbl, surnameLbl]
        for lbl in listLbl {
            if lbl == nameLbl {
                self.updateUITxfSelected(lbl: nameLbl, lineview: nameLineView, state: false)
                break
            }

            if lbl == emailLbl {
                self.updateUITxfSelected(lbl: emailLbl, lineview: emailLineView, state: false)
                break
            }

            if lbl == surnameLbl {
                self.updateUITxfSelected(lbl: surnameLbl, lineview: surenameLineView, state: false)
                break
            }

            if lbl == phoneLbl {
                self.updateUITxfSelected(lbl: phoneLbl, lineview: phoneLbl, state: false)
            }
        }
        textField.resignFirstResponder()
        return true
   }
}


// MARK: Extension datepicker
extension UserController: DatePickerSubviewDelegate {
    func cancelButtonDidTap() {
        self.dissmissKeyBoard()

    }

    func doneButtonDidTap(date: Date!) {
        UIView.animate(withDuration: 0.5, animations:{

            self.view.layoutIfNeeded()
        })
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTxf.text = formatter.string(from: date)
        self.dissmissKeyBoard()

    }

}

extension UserController: UserAPIDelegate {
    func loadingDone(userAPI: UserAPI) {
            DispatchQueue.main.async{
                self.userScV.isHidden = false
                self.activityIndicator.removeFromSuperview()
                self.configUserInformation()

            }
    }

    
}
