//
//  LoginViewController.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/11.
//  Copyright © 2020 BetWay. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    lazy var loginFormView = LoginFormView(parent: view)
    
    var loginTitleText = AuthenticationConstant.Component.login
    var didTapCloseView: (() -> Void)?
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attachLoginForm()
        configureView()
    }
    
    private func attachLoginForm() {
        loginFormView.attachToParent()
    }
    
    private func configureView() {
        self.title = loginTitleText
        view.isOpaque = false
        view.backgroundColor = Colour.transparent
    }
}

// MARK: Network Calls

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
