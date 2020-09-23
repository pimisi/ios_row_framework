//
//  NetworkActivity.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/11.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

typealias GenericVoidClosure = (() -> Void)

class NetworkActivity {
    
    /// The lifecycle of the `NetworkActivity` instance
    enum Status {
        case started, completed
    }
    
    static let shared = NetworkActivity()
    
    private lazy var activityViewController: UIViewController = {
        let viewController = UIViewController()
        
        viewController.view.backgroundColor = Colour.clear
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
        
        return viewController
    }()
    
    /// The status of the `NetworkActivity` instance at any given time
    private(set) var status: Status?
    
    /// The block called when the `NetworkActivity` instance status is completed
    private var completed: GenericVoidClosure?
    /// The block called when the `NetworkActivity` instance status is stopped
    private var stop: GenericVoidClosure?
    
    /// This variable holds the processes that have triggerd a network activity status
    /// This is used to control the lifespan of the activity indicator, which entails that the
    /// `NetworkIndicatorView` is only removed when the `NetworkActivity.Status`
    /// is complete and there is no other process waiting in the queue to keet the `ActivityIndicatorView`
    /// alive and visible. (i.e. the `process` list is empty).
    /// This process list is also cleared when the `complete` closure is called directly.
    private var process: [AnyHashable: Status] = [:]
    
    var activityView: ActivityIndicatorView?
    
    var start: GenericVoidClosure? {
        didSet { status = .started }
    }
    
    /// Calling this closure, directly, removes the network activity for all other processes and removes
    /// any remaining processes that requires the `ActivityIndicatorView` to remain visible.
    var complete: GenericVoidClosure? {
        get {
            stop?()
            process.removeAll()
            return completed
        }
        set {
            status = .completed
            completed = newValue
        }
    }
    
    private init() {
        start = { [weak self] in
            
            guard let self = self else { return }
            
            Application.shared.updateUI {
                if self.activityView == nil {
                    let rootViewController = AppDelegate.rootViewController
                    let presentedViewController = rootViewController?.presentedViewController
                    let hostViewController = presentedViewController is UINavigationController ? presentedViewController?.children.first ?? presentedViewController : presentedViewController
                    
                    self.activityView = ActivityIndicatorView.show(in: self.activityViewController.view)
                    hostViewController?.present(self.activityViewController, animated: true, completion: nil)
                    //                        if let view = presentedViewController.isBeingPresented == true ? rootViewController?.view : presentedViewController.view ?? hostViewController.view {
                    //                        // if let view = rootViewController?.view ?? hostViewController.view {
                    //                            self.activityView = ActivityIndicatorView.show(in: view)
                    //                        }
                    
                }
            }
        }
        
        stop = { [weak self] in
            Application.shared.updateUI {
                self?.activityView?.stop(stopped: {
                    self?.activityView = nil
                })
            }
        }
    }
    
    func status(for key: String) -> Status? {
        return process[key]
    }
    
    func setStatus(_ status: Status?, for key: String) {
        switch status {
        case .started:
            process.set(value: status, for: key)
            
            if self.status != .started {
                start?()
            }
        case .completed:
            process.removeValue(forKey: key)
            
            if process.isEmpty {
                complete?()
            }
        case .none: break
        }
    }
    
}
