//
//  AlertController.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/21.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

class AlertController: UIViewController {
    
    let preferredStyle: UIAlertController.Style
    lazy var alertView = AlertView(parent: view)
    
    override var title: String? {
        get { super.title }
        set { super.title = newValue }
    }
    
    var isSpringLoaded: Bool = true
    var parentController: UIViewController?
    
    var showDismissIcon: Bool = false {
        didSet {
            alertView.showDismissIcon = showDismissIcon
        }
    }
    
    var bodyView: UIView? {
        didSet {
            alertView.bodyView = bodyView
        }
    }
    
    fileprivate func configure() {
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    public init(title: String?, message: String? = nil, preferredStyle: UIAlertController.Style = .alert) {
        
        self.preferredStyle = preferredStyle
        
        super.init(nibName: nil, bundle: nil)
        
        self.title = title
        
        configure()
        
        alertView.layout(title: title, message: message)
        alertView.dismiss = { dismiss in
            self.dismiss()
        }
    }
    
    required init?(coder: NSCoder) {
        self.preferredStyle = .alert
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        parentController = presentingViewController
    }
    
    func addAction(_ action: AlertAction) {
        alertView.addAction(action)
    }
    
    @objc func dismiss() {
        parentController?.dismiss(animated: true, completion: nil)
    }
}

extension AlertController : UISpringLoadedInteractionSupporting {}

extension AlertController {
    
    public typealias AlertActionHandler = ((AlertAction) -> Void)
    
    /// This initializes a `UIAlertController` with a single button having the `title` and `message` provided.
    ///
    /// - parameter title: This is the title for the main button of the alert
    /// - parameter message: This is the message for the body of the alert
    ///
    /// - returns: The instance of the `UIAlertController` that was initialized.
    ///
    public static func alert(withTitle title: String, message: String?) -> AlertController {
        return AlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    /// This initializes a `UIAlertController` with a single button that dismisses the alert or that performs whichever
    /// `AlertAction` is set to the `handler` parameter.
    ///
    /// - parameter title: This is the title for the main button of the alert
    /// - parameter message: This is the message for the body of the alert
    /// - parameter handler: If provided, this is the `UIAlertAction` to run when the button is touched.
    /// If not provided the alert would automaticall be dismissed when the main button is touched.
    ///
    /// - returns: The instance of the `UIAlertController` that was initialized.
    ///
    static func okayAlert(withTitle title: String, message: String?, handler: AlertActionHandler? = nil) -> AlertController {
        let controller = alert(withTitle: title, message: message)
        controller.okayAction(handler: handler)
        return controller
    }
    
    @discardableResult
    func okayAction(style: AlertAction.Style = .primary, handler: AlertActionHandler? = nil) -> AlertController {
        addAction(withTitle: "OK", style: .primary, handler: handler)
        return self
    }
    
    /// This adds a `UIAlertAction` button to the `UIAlertController` instance before presenting it to the user.
    /// - parameter title: This is the title for the action being added
    /// - parameter style: This is the `UIAlertAction.Style` to use for the resulting button of the action.
    ///
    func addAction(withTitle title: String, style: AlertAction.Style = .primary, handler: AlertActionHandler?) {
        let action = AlertAction(title: title, style: style, handler: handler)
        self.addAction(action)
    }
    
    /// This adds a secondary action button to the`UIAlertController` with a `UIAlertAction.Style.default` style before presenting it to the user
    ///
    /// - returns: Returns the instance of the `UIAlertController` that the action button is added to.
    @discardableResult
    func secondary(title: String = "RETRY", handler: AlertActionHandler?) -> AlertController {
        if handler != nil {
            addAction(withTitle: title, style: .system(.default), handler: handler)
        }
        return self
    }
    
    /// This is used to show the `UIAlertControllerInstance` to the user.
    func showIn(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.present(self, animated: animated, completion: completion)
    }
}
