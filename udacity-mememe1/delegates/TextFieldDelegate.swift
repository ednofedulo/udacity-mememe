//
//  TextBoxDelegate.swift
//  udacity-mememe1
//
//  Created by Edno Fedulo on 11/02/18.
//  Copyright © 2018 Fedulo. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate : NSObject, UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
