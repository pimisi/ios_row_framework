//
//  MainViewController.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/10.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var loginBarButton: UIBarButtonItem!
    
    private let loginViewController = LoginViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoginButton()
    }
    
    private func configureLoginButton() {
        let loginButton = Button(type: .primary, frame: CGRect(origin: .zero, size: CGSize(width: Layout.Size.size70, height: Layout.Size.size32)))
        loginButton.setTitle(loginButtonTitle, for: .normal)
        loginButton.contentEdgeInsets = UIEdgeInsets(top: Layout.spacing4, left: Layout.spacing10, bottom: Layout.spacing4, right: Layout.spacing10)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        loginBarButton.customView = loginButton
    }
    
    @objc private func didTapLogin() {
        // LoginViewController.instance.display(in: self)
        attach(viewController: LoginViewController.instance, includeView: false)
        
        // PlayPen.shared.login()
        //        let alertController = AlertController.okayAlert(withTitle: "displayMessage.title", message: "displayMessage.detail")
        //            .secondary(handler: nil)
        //        alertController.showIn(self, animated: true, completion: nil)
        //        alertController.showIn(self, animated: true, completion: {
        //                self.action = nil
        //            })
        
        //        let loginAlert = AlertController(title: Localizable.localized(key: "LOGIN"), message: "This is a message")
        //
        //        let loginViewContainer = UIView()
        //        loginViewContainer.backgroundColor = .blue
        //        let loginView = LoginFormView(parent: loginViewContainer)
        //        loginView.attachToParent()
        //        loginAlert.bodyView = loginViewContainer
        //        loginAlert.showDismissIcon = true
        
        //        parent?.present(loginAlert, animated: true, completion: {
        //            PlayPen.shared.login()
        //        })
    }
    
    @IBAction func didTouchUpOnRegistration(_ sender: Any) {
        presentRegistrationView()
    }
    
    @IBAction func didTouchUpOnChat(_ sender: Any) {
    }
    
    @IBAction func didTouchUpOnPromo(_ sender: Any) {
    }
}

extension MainViewController {
    func presentRegistrationView() {
        let controller = RegistrationViewController.instance
        controller.view.frame = self.view.bounds
        controller.willMove(toParent: self)
        addChild(controller)
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
}

// MARK: Localizable

extension MainViewController {
    var loginButtonTitle: String { Localizable.localized(key: "LOGIN")}
    
    @discardableResult
    func attach(viewController controller: UIViewController, includeView: Bool = true) -> UIViewController {
        controller.willMove(toParent: self)
        addChild(controller)
        
        if includeView {
            controller.view.frame = view.bounds
            view.addSubview(controller.view)
        }
        controller.didMove(toParent: self)
        
        return controller
    }
}
