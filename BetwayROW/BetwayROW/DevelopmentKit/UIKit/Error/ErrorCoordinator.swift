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
    
    var action: ((UIAlertAction) -> Void)?
    
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
            DispatchQueue.main.async {
                if let viewController = AppDelegate.rootViewController {
                    UIAlertController.okayAlert(withTitle: displayMessage.title, message: displayMessage.detail)
                        .secondary(handler: self.action)
                        .showIn(viewController, completion: {
                            self.action = nil
                        })
                }
            }
        }
    }
}
