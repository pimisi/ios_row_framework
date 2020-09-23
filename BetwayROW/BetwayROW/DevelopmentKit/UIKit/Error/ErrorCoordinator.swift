//
//  ErrorCoordinator.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/11.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

class ErrorCoordinator {
    
    static var shared = ErrorCoordinator()
    
    var error: Error? {
        didSet {
            processError()
        }
    }
    
    var action: ((AlertAction) -> Void)?
    
    var suspendedPresentedViewController: UIViewController?
    
    fileprivate func displayAlert(for displayMessage: Constant.UIMessage) {
        Application.shared.updateUI {
            guard let rootViewController = AppDelegate.rootViewController,
                  let presented = rootViewController.presentedViewController else {
                return
            }
            let alertController = AlertController(title: displayMessage.title, message: displayMessage.detail)
            
            if presented.presentedViewController != nil {
                self.suspendedPresentedViewController = presented.presentedViewController
                
                alertController
                    .okayAction(handler: { _ in
                        alertController.dismiss(animated: true) {
                            if let suspendedViewController = self.suspendedPresentedViewController {
                                presented.present(suspendedViewController, animated: true, completion: nil)
                            }
                        }
                    })
                    .secondary(handler: self.action)
                
                presented.presentedViewController?.dismiss(animated: false, completion: {
                    alertController.showIn(presented, completion: { self.action = nil })
                })
            } else {
                alertController
                    .okayAction()
                    .secondary(handler: self.action)
                    .showIn(presented, completion: {
                        self.action = nil
                    })
            }
        }
    }
    
    func processError() {
        var uiMessage: Constant.UIMessage?
        
        if let failure = error as? Failure {
            if let error = failure.error as? FailureReason {
                
                switch error {
                case .internetConnectionOffline:
                    uiMessage = Constant.API.Network.Error.noInternetConnection
                case .unknown: uiMessage = Constant.UIMessage(title: failure.title ?? "Error", detail: error.message ?? "Unknown")
                case .sslError:
                    uiMessage = Constant.API.Response.Error.ssl.display
                    debugLog(Constant.API.Response.Error.ssl.debug ?? "ssl error")
                default:
                    uiMessage = error.message != nil ? Constant.UIMessage(title: failure.title ?? "Error", detail: failure.description) : nil
                }
            } else if let error = failure.error as? APIError {
                uiMessage = error.message != nil ? Constant.UIMessage(title: failure.title ?? "Error", detail: failure.description) : nil
            }
        }
        
        if let displayMessage = uiMessage {
            displayAlert(for: displayMessage)
        }
    }
}
