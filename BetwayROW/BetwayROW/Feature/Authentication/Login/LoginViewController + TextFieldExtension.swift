//
//  LoginViewController + TextFieldExtension.swift
//  BetwayROW
//
//  Created by user on 2020/09/15.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import UIKit

extension LoginViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if let textField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            textField.becomeFirstResponder()
            return false
        } else {
            textField.resignFirstResponder()
            return true
        }
    }
}
