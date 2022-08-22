//
//  OtpViewModel.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 11/08/2022.
//

import Foundation
import UIKit

protocol OtpViewDelegate: AnyObject {
    func didTextChange(otpView: OtpView , listOtpItemview: [OtpItemView])

}


class OtpView: UIView , UIKeyInput {

    // MARK: variable
    var keyboardType: UIKeyboardType = .numberPad
    var listOtpItemView = [OtpItemView]()
    weak var delegate: OtpViewDelegate?
    var isShowKeyboard: Bool = false

    // MARK: Outlet
    var stackView: UIStackView!
    var indexFocused: Int = 0

    // MARK: init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configStackView()

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configStackView()
    }

    // MARK: Config
    func configStackView() {
        self.stackView = UIStackView()
        self.stackView.axis = .horizontal
        self.stackView.spacing = 8
        self.stackView.backgroundColor = .clear

        for index  in 0 ... 5 {
            let itemOtpview = OtpItemView()
            itemOtpview.addTarget(self, action: #selector(otpItemDidTap(_:)), for: .touchUpInside)
            itemOtpview.translatesAutoresizingMaskIntoConstraints = false
            itemOtpview.tag = index
            itemOtpview.cornerRadius = 8
            if index == 0 {
                itemOtpview.isFocusing = true
                itemOtpview.focus()
                
            }


            self.listOtpItemView.append(itemOtpview)
            self.stackView.addArrangedSubview(itemOtpview)

            NSLayoutConstraint.activate([
                
                itemOtpview.topAnchor.constraint(equalTo: self.stackView.topAnchor),
                itemOtpview.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor),
                itemOtpview.widthAnchor.constraint(equalTo: itemOtpview.heightAnchor),

            ])

        }
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)

        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }



    // MARK: Action

    @objc func otpItemDidTap(_ sender: OtpItemView) {
        self.becomeFirstResponder()
        if self.isFocused == true {
            self.indexFocused = sender.tag
        }
    }

    func updateFocusing(isNexTo: Bool) {
        if isNexTo {
            self.nextToFocusing()
            return
        }

        self.backToFocusing()

    }

    func nextToFocusing() {
        self.listOtpItemView[self.indexFocused].focus()
    }

    func backToFocusing(){
        self.listOtpItemView[min(self.indexFocused + 1, self.listOtpItemView.count - 1)].lock()
        self.listOtpItemView[ self.indexFocused].focus()
    }

}

// MARK: UIKeyInput
extension OtpView {
    var hasText: Bool {
        return ((self.listOtpItemView[self.indexFocused].optLbl!.text)!.count == 1)
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    func insertText(_ text: String) {
        for itemOtp in listOtpItemView {
            if itemOtp.tag == self.indexFocused && itemOtp.isFocusing  {
                itemOtp.optLbl!.text = text
                itemOtp.lock()
            }
        }
        self.indexFocused = min(self.indexFocused + 1 , self.listOtpItemView.count - 1)
        updateFocusing(isNexTo: true)
        self.delegate?.didTextChange(otpView: self, listOtpItemview: self.listOtpItemView)
    }

    func deleteBackward() {
        if hasText {
            self.listOtpItemView[self.indexFocused].optLbl!.text! = ""
          //  self.listOtpItemView[self.indexFocused].lock()
            self.indexFocused = min(self.indexFocused , self.listOtpItemView.count - 1)
            updateFocusing(isNexTo: false)
            self.delegate?.didTextChange(otpView: self, listOtpItemview: self.listOtpItemView)
            return
        }
        self.listOtpItemView[self.indexFocused].optLbl!.text! = ""
        self.listOtpItemView[self.indexFocused].lock()
        self.indexFocused = max(0, self.indexFocused - 1)
        updateFocusing(isNexTo: false)
        self.delegate?.didTextChange(otpView: self, listOtpItemview: self.listOtpItemView)
        
    }
}
