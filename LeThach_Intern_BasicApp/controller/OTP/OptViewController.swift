//
//  OptViewController.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 09/08/2022.
//

import UIKit

class OptViewController: UIViewController, OtpViewDelegate {
    // MARK: Variable
    var otpView = OtpView()
    var appColor = ColorAppModel()
    var countTime: Int = 5
    var timeController: Timer!
    var isButtonLocked: Bool = true
    var colorApp = ColorAppModel()
    var isDoneOtp: Bool = false
    var heightKeyboard: CGFloat = 0
    var phoneString: String = ""


    // MARK: Outlet
    @IBOutlet weak private var introLbl: UILabel!
    @IBOutlet weak private var continueBtn: UIButton!
    @IBOutlet weak private var resendButton: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var errAndResendStack: UIStackView!


    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        autoCountTimeForResend()
        config()
        otpView.delegate = self
        registerOBS()

        self.otpView.otpItemDidTap( self.otpView.listOtpItemView[0])

    }

    // MARK: Config
    func config() {
        configIntroLbl()
        configOtp()
        updateStateContinueBnt(stateOfButton: false)
        updateStateLockResendBnt(stateOfButton: false)
        updateErrosLbl(isHidden: true)

    }

    func configIntroLbl() {
        let describeSting: String = "Vui lòng nhập mã gồm 6 chữ số đã được gửi đến bạn vào số điện thoại "
        let phoneNumber: String = converPhoneNuber(phoneNumber: phoneString)

        let styleDescribeString = [NSAttributedString.Key.font : UIFont(name: "NunitoSans-Regular", size: 14)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        let stylePhoneString = [NSAttributedString.Key.font : UIFont(name: "NunitoSans-Bold", size: 14)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        let describeLabel = NSMutableAttributedString(string: describeSting, attributes: styleDescribeString)
        let phoneLabel = NSMutableAttributedString(string: phoneNumber, attributes: stylePhoneString)
        describeLabel.append(phoneLabel)
        introLbl.attributedText = describeLabel
    }


    func configContinueBnt() {
        self.continueBtn.translatesAutoresizingMaskIntoConstraints = false
        self.continueBtn.layer.borderWidth = 1.5
        self.continueBtn.layer.cornerRadius = 24
        NSLayoutConstraint.activate([
            self.continueBtn.heightAnchor.constraint(equalToConstant: 48),
            self.continueBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor , constant: 24),
            self.continueBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor , constant: -24),
            self.continueBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor , constant:  -50 ),
        ])
        updateStateContinueBnt(stateOfButton: false)


        self.otpView.otpItemDidTap( self.otpView.listOtpItemView[0])


    }

    func configOtp() {
        self.view.addSubview(otpView)
        otpView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            self.otpView.trailingAnchor.constraint(equalTo: self.introLbl.trailingAnchor),
            self.otpView.leadingAnchor.constraint(equalTo: self.introLbl.leadingAnchor),
            self.otpView.heightAnchor.constraint(equalToConstant: 42),
            self.otpView.bottomAnchor.constraint(equalTo: self.errAndResendStack.topAnchor,  constant: -16)
        ])
    }

    func registerOBS() {
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: Update

    func updateErrosLbl(isHidden: Bool){
        self.errorLbl.isHidden = isHidden
    }


    func autoCountTimeForResend() {
        self.resendButton.setTitle("Gửi lại sau \(self.countTime)s", for: .normal)
        timeController = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }


    func updateStateLockResendBnt(stateOfButton: Bool) {
        self.resendButton.isEnabled = stateOfButton
        self.resendButton.layer.borderColor = stateOfButton ? colorApp.boderFocusColor.cgColor : colorApp.boderDisbaleColor.cgColor
        self.resendButton.setTitleColor(stateOfButton ? appColor.buttonPrimaryColor : .lightGray, for: .normal)
        if stateOfButton {
            self.resendButton.addTarget(self, action: #selector(clickResenBnt), for: .touchUpInside)
        }
    }


    func updateStateContinueBnt(stateOfButton: Bool) {
        self.continueBtn.isUserInteractionEnabled = stateOfButton
        self.continueBtn.layer.borderColor = stateOfButton ? colorApp.boderFocusColor.cgColor : colorApp.boderDisbaleColor.cgColor
        self.continueBtn.backgroundColor = stateOfButton ? colorApp.buttonPrimaryColor : colorApp.buttonSecondColor
    }

    // MARK: Action
    @IBAction func backBnt(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    func converPhoneNuber(phoneNumber: String) -> String {
        var res = ""
        var cnt: Int = 0
        let arrayPhoneNumber = Array(phoneNumber)
        print(arrayPhoneNumber)
        if arrayPhoneNumber.first != "0" {
            res = "+84"
            cnt = 0
        }

        for i in 0 ..< arrayPhoneNumber.count {
            print(cnt)
            if cnt % 3 == 0 && cnt + 3 <= arrayPhoneNumber.count {
                res.append(" ")
            }
            res.append(arrayPhoneNumber[i])
            cnt += 1
        }


        return res
    }

    func resetOtpItem() {
        for i in 0 ..< self.otpView.listOtpItemView.count {
            if i == 0 {
                self.otpView.listOtpItemView[i].optLbl.text = ""
                self.otpView.listOtpItemView[i].focus()
            }
            else {
                self.otpView.listOtpItemView[i].optLbl.text = ""
                self.otpView.listOtpItemView[i].lock()
            }
        }
        self.otpView.indexFocused = 0
    }


    // MARK: Objc func
    @objc func updateTime() {
        self.countTime -= 1
        if self.countTime == 0 {
            timeController.invalidate()
            self.resendButton.setTitle("Gửi lại mã OTP", for: .normal)
            updateStateLockResendBnt(stateOfButton: true)
        }
        else {
            self.resendButton.setTitle("Gửi lại sau \(self.countTime)s", for: .normal)

        }

    }

    @objc func clickResenBnt() {
        self.countTime = 5
        self.updateStateLockResendBnt(stateOfButton: false)
        self.autoCountTimeForResend()
        self.updateErrosLbl(isHidden: true)
        resetOtpItem()

    }

    @objc func nextScreen() {
        for item in otpView.listOtpItemView {
            if item.optLbl.text != "1" {
                self.updateErrosLbl(isHidden: false)
                return
            }
        }
        let vc = HomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func KeyboardWillShow(notification: Notification){
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0

        UIView.animate(withDuration: duration) {[weak self] in
            guard let self = self else { return}
            self.continueBtn.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height )
        }
    }

    @objc func KeyboardWillHide(notification: Notification) {
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0

        UIView.animate(withDuration: duration) {[weak self] in
            guard let self = self else { return}

            self.continueBtn.transform = .identity
        }
    }
}

// MARK: Extension

extension OptViewController {
    func didTextChange(otpView: OtpView, listOtpItemview: [OtpItemView]) {
        if otpView.indexFocused == listOtpItemview.count - 1 && listOtpItemview[listOtpItemview.count - 1].optLbl.text?.count == 1 {
            self.updateStateContinueBnt(stateOfButton: true)
            self.continueBtn.addTarget(self, action: #selector(nextScreen), for: .touchUpInside)
            return
        }
        self.updateStateContinueBnt(stateOfButton: false)
    }


}


