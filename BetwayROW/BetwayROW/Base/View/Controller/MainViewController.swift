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
    
    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return UIRectEdge.bottom
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return false
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
    }
    
    private func configureButton() {
        let loginButton = Button(type: .primary)
        loginButton.setTitle(loginButtonTitle, for: .normal)
        loginButton.contentEdgeInsets = UIEdgeInsets(top: Layout.spacing4,
                                                     left: Layout.spacing10,
                                                     bottom: Layout.spacing4,
                                                     right: Layout.spacing10)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        loginBarButton.customView = loginButton
    }
    
    @objc private func didTapLogin() {
        loginViewController.view.frame.origin = CGPoint(x: 0.0,
                                                        y: Layout.spacing80)
        loginViewController.view.frame.size = CGSize(width: view.frame.width,
                                                     height: view.frame.height)
        view.addSubview(loginViewController.view)
        loginViewController.didMove(toParent: self)
        
        loginViewController.didTapCloseView = { [weak self] in
            self?.didTapCloseLoginView()
        }
    }
    
    private func didTapCloseLoginView() {
        loginViewController.view.removeFromSuperview()
        loginViewController.removeFromParent()
    }
    
}

// MARK: Localizable
extension MainViewController {
    var loginButtonTitle: String { Localization.localized(key: "LOGIN")}
}
