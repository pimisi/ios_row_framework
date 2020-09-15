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
        textField.delegate = self
        textField.placeholder = userNamePlaceHolderText
        return textField
    }()
    
    lazy var passwordTextField: InputTextField = {
        let textField = InputTextField()
        textField.delegate = self
        textField.isSecureTextEntry = true
        textField.placeholder = passwordPlaceHolderText
        return textField
    }()
    
    lazy var loginButton: PrimaryButton = {
        let button = PrimaryButton()
        button.isEnabled = false
        button.setTitle(loginButtonText, for: .normal)
        return button
    }()
    
    lazy var registerButton: SecondaryButton = {
        let button = SecondaryButton()
        button.isEnabled = false
        button.setTitle(registerButtonText, for: .normal)
        return button
    }()
    
    lazy var loginStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameTextField, passwordTextField, loginButton, registerButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = Layout.spacing16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var loginBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Colours.shared.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        constrainViews()
    }
    
    private func configureView() {
        self.title = loginTitleText
        view.isOpaque = false
        view.backgroundColor = Colours.shared.black.withAlphaComponent(0.5)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: closeButtonImage, style: .plain, target: self, action: #selector(didTapDismissController))
    }

    private func constrainViews() {
        view.addSubview(loginBackgroundView)
        loginBackgroundView.addSubview(loginStackView)
        
        loginBackgroundView.leftAnchor ->> view.leftAnchor
        loginBackgroundView.rightAnchor ->> view.rightAnchor
        loginBackgroundView.topAnchor ->> view.topAnchor
        loginBackgroundView.height(Layout.spacing400)
        
        loginStackView.leftAnchor.constraint(equalTo: loginBackgroundView.leftAnchor, constant: Layout.spacing16).isActive = true
        loginStackView.rightAnchor.constraint(equalTo: loginBackgroundView.rightAnchor, constant: -Layout.spacing16).isActive = true
        loginStackView.topAnchor.constraint(equalTo: loginBackgroundView.topAnchor, constant: Layout.spacing120).isActive = true
        loginStackView.bottomAnchor.constraint(equalTo: loginBackgroundView.bottomAnchor, constant: -Layout.spacing48).isActive = true
    }
    
    @objc private func didTapDismissController() {
        dismiss(animated: false, completion: nil)
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
    var loginTitleText: String { Localisable.localized(key: "LOG_IN")}
    var registerButtonText: String { Localisable.localized(key: "REGISTER")}
    var closeButtonImage: UIImage { UIImage(named: "ic-close") ?? UIImage()}
}
