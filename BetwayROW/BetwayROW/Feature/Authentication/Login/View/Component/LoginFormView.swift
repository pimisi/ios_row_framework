//
//  LoginFormView.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/16.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

class LoginFormView: UIView {
    
    private(set) var parent: UIView?
    
    private var closeButtonImage = Image.close
    private var loginButtonText = AuthenticationConstant.Component.Button.login
    private var loginTitleText = AuthenticationConstant.Component.login
    private var registerButtonText = AuthenticationConstant.Component.Button.register
    
    private struct Placeholder {
        static let username = AuthenticationConstant.Component.username
        static let password = AuthenticationConstant.Component.password
    }
    
    private struct Text {
        
        static let login = AuthenticationConstant.Component.login
        
        // swiftlint:disable nesting
        struct `Button` {
            static let close = Image.close
            static let login = AuthenticationConstant.Component.Button.login
            static let register = AuthenticationConstant.Component.Button.register
            static let forgotPassword = AuthenticationConstant.Component.Button.forgotPassword
        }
    }

    weak var textFielfDelegate: UITextFieldDelegate?
    
    lazy var dismissButton: LoginHeaderView = {
        let view = LoginHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Form Elements
    
    lazy var usernameTextField: TextField = {
        let textField = TextField()
        textField.delegate = textFielfDelegate
        textField.placeholder = Placeholder.username
        textField.bordered(width: 1, cornerRadius: 2, color: Colour.Grey.light)
        textField.leftPadding = 10
        textField.font = UIFont.systemFont(ofSize: 16.0)
        return textField
    }()
    
    lazy var passwordTextField: TextField = {
        let textField = TextField(type: .password)
        textField.delegate = textFielfDelegate
        textField.placeholder = Placeholder.password
        textField.bordered(width: 1, cornerRadius: 2, color: Colour.Grey.light)
        textField.leftPadding = 10
        textField.font = UIFont.systemFont(ofSize: 16.0)
        return textField
    }()
    
    let loginButton: UIButton = genericFormButton(type: .primary, title: Text.Button.login)
    let registerButton: UIButton = genericFormButton(type: .secondary, title: Text.Button.register)
    let forgotPasswordButton: UIButton = genericFormButton(title: Text.Button.forgotPassword)
    
    // MARK: - Form
    
    lazy var form: UIView = {
        let view = UIView()
        view.backgroundColor = Colour.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var elementStack: UIStackView = {
        
        loginButton.translateSizeToConstraints()
        registerButton.translateSizeToConstraints()
        
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField, loginButton, registerButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = Layout.spacing16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var didTapCloseView: (() -> Void)?
    
    init(parent: UIView) {
        self.parent = parent
        
        super.init(frame: .zero)
        
        setDismissView()
    }
    
    required init?(coder: NSCoder) {
        self.parent = nil
        super.init(coder: coder)
    }
    
    private func setDismissView() {
        dismissButton.handleCloseButtonTapped = { [weak self] in
            self?.didTapCloseView?()
        }
    }
    
    func attachToParent() {
        
        guard let parent = parent else {
            debugLog(String(describing: self), message: "The parent view cannot be nil")
            return
        }
        
        form.fit(inside: self)
        elementStack.fit(inside: form, leading: Layout.spacing20, top: Layout.spacing16, trailing: Layout.spacing20, bottom: Layout.spacing16)
        fit(inside: parent)
    }
    
    private static func genericFormButton(type: Button.CustomType = .default(type: .custom), enabled: Bool = false, title: String) -> UIButton {
        let button: UIButton = Button(type: type )
        button.isEnabled = false
        button.setTitle(title, for: .normal)
        return button
    }
}
