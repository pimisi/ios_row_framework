//
//  ActivityIndicatorView.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/11.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        
        return activityIndicator
    }()
    
    private func addActivityIndicator() {
        activityIndicator.center(in: self)
    }
    
    private func startAnimation() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    private func stopAnimation() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.removeFromSuperview()
        }
    }
    
    @discardableResult
    class func show(in view: UIView) -> ActivityIndicatorView {
        let indicatorView = ActivityIndicatorView(frame: view.bounds)
        indicatorView.isOpaque = false;
        
        view.addSubview(indicatorView)
        view.isUserInteractionEnabled = false
        
        indicatorView.addActivityIndicator()
        
        view.addSubview(indicatorView)
        view.isUserInteractionEnabled = false
        
        indicatorView.backgroundColor = .white
        indicatorView.alpha = 0.9
        
        indicatorView.startAnimation()
        
        return indicatorView
    }
    
    @objc public func stop(stopped: (() -> Void)? = nil) {
        self.superview?.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
        }) { _ in
            self.stopAnimation()
            stopped?()
        }
    }
}
