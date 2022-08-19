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
    var countTime: Int = 3
    var timeController: Timer!
    var isButtonLocked: Bool = true
    var colorApp = ColorAppModel()
    var isDoneOtp: Bool = false
    var heightKeyboard: CGFloat = 0
    var phoneString: String = ""

    // MARK: Outlet
    @IBOutlet weak private var introLbl: UILabel!
    @IBOutlet weak private var continueBtn: UIButton!
    private var resendButton: UIButton!
    @IBOutlet private weak var errorLbl: UILabel!

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        autoCountTimeForResend()
        otpView.delegate = self

    }

    // MARK: Config
    func config() {
        configIntroLbl()
        configOtp()
        configResendButton()
        configContinueBnt()

    }
    func configIntroLbl() {
        let describeSting: String = "Vui lòng nhập mã gồm 4 chữ số đã được gửi đến bạn vào số điện thoại "
        let phoneNumber: String = (self.phoneString.first == "0" ? self.phoneString : "+84 \(self.phoneString)")

        let styleDescribeString = [NSAttributedString.Key.font : UIFont(name: "NunitoSans-Regular", size: 14)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        let stylePhoneString = [NSAttributedString.Key.font : UIFont(name: "NunitoSans-Bold", size: 14)!, NSAttributedString.Key.foregroundColor : UIColor.black]
        let describeLabel = NSMutableAttributedString(string: describeSting, attributes: styleDescribeString)
        let phoneLabel = NSMutableAttributedString(string: phoneNumber, attributes: stylePhoneString)
        describeLabel.append(phoneLabel)
        introLbl.attributedText = describeLabel
        self.errorLbl.isHidden = true
    }

    func configOtp() {
        self.view.addSubview(otpView)
        otpView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.otpView.topAnchor.constraint(equalTo: self.introLbl.bottomAnchor, constant: 32 ),
            self.otpView.trailingAnchor.constraint(equalTo: self.introLbl.trailingAnchor),
            self.otpView.leadingAnchor.constraint(equalTo: self.introLbl.leadingAnchor),
            self.otpView.heightAnchor.constraint(equalToConstant: 42)
        ])
    }

    func configResendButton () {
        self.resendButton = UIButton()
        self.resendButton.setTitle("Gửi lại sau \(self.countTime)s", for: .normal)
        self.resendButton.titleLabel?.font = UIFont(name: "NunitoSans-Regular", size: 14)
        self.resendButton.layer.borderWidth = 1.6
        self.resendButton.layer.cornerRadius = 8
        self.updateStateLockResendBnt(stateOfButton: false)
        self.view.addSubview(resendButton)
        self.resendButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.resendButton.topAnchor.constraint(equalTo: self.errorLbl.bottomAnchor , constant: 32),
            self.resendButton.leadingAnchor.constraint(equalTo:self.view.leadingAnchor, constant: 98),
            self.resendButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -97),
            self.resendButton.heightAnchor.constraint(equalToConstant: 32),

        ])
    }

    // MARK: Action
    @IBAction func backBnt(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    func autoCountTimeForResend() {
        timeController = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }


    func updateStateLockResendBnt(stateOfButton: Bool) {
        self.resendButton.isUserInteractionEnabled = stateOfButton
        self.resendButton.layer.borderColor = stateOfButton ? colorApp.boderFocusColor.cgColor : colorApp.boderDisbaleColor.cgColor
        self.resendButton.setTitleColor(stateOfButton ? appColor.buttonPrimaryColor : .lightGray, for: .normal)
        if stateOfButton {
            self.resendButton.addTarget(self, action: #selector(clickResenBnt), for: .touchUpInside)
        }
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

    func updateStateContinueBnt(stateOfButton: Bool) {
        self.continueBtn.isUserInteractionEnabled = stateOfButton
        self.continueBtn.layer.borderColor = stateOfButton ? colorApp.boderFocusColor.cgColor : colorApp.boderDisbaleColor.cgColor
        self.continueBtn.backgroundColor = stateOfButton ? colorApp.buttonPrimaryColor : colorApp.buttonSecondColor
    }

    func updateLayoutContinueBnt(isShowkeyBoard: Bool) {
        self.continueBtn.translatesAutoresizingMaskIntoConstraints = false
        if isShowkeyBoard {
            self.continueBtn.removeConstraint( self.continueBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor , constant:  -50 ))
            NSLayoutConstraint.activate([
                self.continueBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor , constant: -(self.heightKeyboard + 22)),
            ])
        }

        if !isShowkeyBoard {
            self.continueBtn.removeConstraint( self.continueBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor , constant:  -(self.heightKeyboard + 22) ))
            NSLayoutConstraint.activate([
                self.continueBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor , constant:  -50 ),
            ])

        }

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
        self.countTime = 3
        self.updateStateLockResendBnt(stateOfButton: false)
        self.autoCountTimeForResend()

    }

    @objc func nextScreen() {
        for item in otpView.listOtpItemView {
            if item.optLbl.text != "1" {
                self.errorLbl.isHidden = false
                return
            }
        }
        let vc = HomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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

    func checkShowKeyBoard(otpView: OtpView, stateKeyBoard: Bool, notificaiontInfor: Notification) {
        if stateKeyBoard {
            let info = notificaiontInfor.userInfo!
            let keyboardFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let height = keyboardFrame.height
            self.heightKeyboard = height
            let time = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
            UIView.animate(withDuration: time) {
                self.updateLayoutContinueBnt(isShowkeyBoard: stateKeyBoard)
            }

        }
    }

}


