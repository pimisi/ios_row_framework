//
//  LoginViewController.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/11.
//  Copyright © 2020 BetWay. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    static var instance: LoginViewController {
        return LoginViewController(nibName: nil, bundle: Bundle(for: LoginViewController.self))
    }
    
    let loginViewContainer = UIView()
    
    lazy var loginView = LoginFormView(parent: loginViewContainer)
    lazy var loginViewModel = LoginViewModel()
    
    // var loginTitleText = AuthenticationConstant.Component.login
    // var didTapCloseView: (() -> Void)?
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attachLoginForm()
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        attachLoginForm()
        configureLoginForm()
        // self.loginViewModel.login(username: "EbesterNot", password: "password")
    }
    
    private func attachLoginForm() {
        let loginAlert = AlertController(title: Localizable.localized(key: "LOGIN"))

        loginView.attachToParent()
        loginAlert.bodyView = loginViewContainer
        loginAlert.showDismissIcon = true
        
        // parent?.present(loginAlert, animated: true, completion: nil)
        self.loginViewModel.login(username: "EBester061", password: "esport12")
    }
    
    private func configureLoginForm() {
        loginView.didTouchUpOnLogin = {
            self.loginViewModel.login(username: "EBester06", password: "esport12")
        }
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
