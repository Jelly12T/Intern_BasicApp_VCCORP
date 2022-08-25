//
//  DatePickerSubview.swift
//  MicrosoftTodo
//
//  Created by linzsc on 14/01/2021.
//

import UIKit

protocol DatePickerSubviewDelegate: AnyObject {
    func cancelButtonDidTap()
    func doneButtonDidTap(date: Date!)
}

class DatePickerSubview: UIView {

    @IBOutlet weak var datePicker: UIDatePicker!
    weak var delegate: DatePickerSubviewDelegate?
    @IBAction func doneButtonDidTap(_ sender: Any) {
        delegate?.doneButtonDidTap(date: datePicker.date)
    }
    
    @IBAction func cancelButtonDidTap(_ sender: Any) {
        delegate?.cancelButtonDidTap()
    }
}
