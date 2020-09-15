//
//  LoginViewController.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/11.
//  Copyright © 2020 BetWay. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    
    lazy var userNameTextField: InputTextField = {
        let textField = InputTextField()
        textField.placeholder = userNamePlaceHolderText
        return textField
    }()
    
    lazy var passwordTextField: InputTextField = {
        let textField = InputTextField()
        textField.placeholder = passwordPlaceHolderText
        return textField
    }()
    
    lazy var loginButton: PrimaryButton = {
        let button = PrimaryButton()
        button.isEnabled = false
        button.setTitle(loginButtonText, for: .normal)
        return button
    }()
    
    lazy var registerButton: PrimaryButton = {
        let button = PrimaryButton()
        button.isEnabled = false
        button.setTitle(registerButtonText, for: .normal)
        return button
    }()
    
    lazy var loginStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameTextField, passwordTextField, loginButton, registerButton])
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = Layout.spacing16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colours.shared.white
        constrainViews()
    }

    private func constrainViews() {
        view.addSubview(loginStackView)
        loginStackView.leftAnchor ->> view.leftAnchor
        loginStackView.rightAnchor ->> view.rightAnchor
        loginStackView.topAnchor ->> view.topAnchor
        loginStackView.height(Layout.spacing300)
    }
}

// MARK: Network Calls
extension LoginViewController {
    fileprivate func handleLogin() {
        
    }
}

// MARK: Localisable
extension LoginViewController {
    var userNamePlaceHolderText: String { Localisable.localized(key: "USER_NAME")}
    var passwordPlaceHolderText: String { Localisable.localized(key: "PASSWORD")}
    var loginButtonText: String { Localisable.localized(key: "LOGIN")}
    var registerButtonText: String { Localisable.localized(key: "REGISTER")}
}
