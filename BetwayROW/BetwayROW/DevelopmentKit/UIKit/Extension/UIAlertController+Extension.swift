//
//  UIAlertController+Extension.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/11.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    public typealias AlertAction = ((UIAlertAction) -> Void)
    
    /// This initializes a `UIAlertController` with a single button having the `title` and `message` provided.
    ///
    /// - parameter title: This is the title for the main button of the alert
    /// - parameter message: This is the message for the body of the alert
    ///
    /// - returns: The instance of the `UIAlertController` that was initialized.
    ///
    public static func alert(withTitle title: String, message: String?) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
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
    static func okayAlert(withTitle title: String, message: String?, handler: AlertAction? = nil) -> UIAlertController {
        let controller = alert(withTitle: title, message: message)
        controller.addAction(withTitle: "OK", style: .default, handler: handler)
        return controller
    }
    
    /// This adds a `UIAlertAction` button to the `UIAlertController` instance before presenting it to the user.
    /// - parameter title: This is the title for the action being added
    /// - parameter style: This is the `UIAlertAction.Style` to use for the resulting button of the action.
    ///
    func addAction(withTitle title: String, style: UIAlertAction.Style, handler: AlertAction?) {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        self.addAction(action)
    }
    
    /// This adds a secondary action button to the`UIAlertController` with a `UIAlertAction.Style.default` style before presenting it to the user
    ///
    /// - returns: Returns the instance of the `UIAlertController` that the action button is added to.
    @discardableResult
    func secondary(title: String = "RETRY", handler: AlertAction?) -> UIAlertController {
        if handler != nil {
            addAction(withTitle: title, style: .default, handler: handler)
        }
        return self
    }
    
    /// This is used to show the `UIAlertControllerInstance` to the user.
    func showIn(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.present(self, animated: animated, completion: completion)
    }
}
