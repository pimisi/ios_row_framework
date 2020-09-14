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
        let loginButton = PrimaryButton()
        loginButton.setTitle(loginButtonTitle, for: .normal)
        loginButton.contentEdgeInsets = UIEdgeInsets(top: 5.0,
                                                     left: 10.0,
                                                     bottom: 5.0,
                                                     right: 10.0)
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        loginBarButton.customView = loginButton
    }
    
    @objc func didTapLogin() {
        debugLog("Logged In")
    }
    
}

// MARK: Localizable
extension MainViewController {
    var loginButtonTitle: String { Localisable.localized(key: "LOGIN")}
}
