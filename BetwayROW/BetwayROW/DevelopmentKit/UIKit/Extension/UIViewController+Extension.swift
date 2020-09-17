//
//  UIViewController+Extension.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/17.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import UIKit

extension UIViewController {
    
    private func configureNavigationBar(isTranslucent: Bool = false,
                               backgroundImage: UIImage? = nil, shadowImage: UIImage? = nil,
                               barStyle: UIBarStyle = .default,
                               hidden: Bool = false, animated: Bool = true) {
        
        navigationController?.setNavigationBarHidden(hidden, animated: animated)
        navigationController?.navigationBar.setBackgroundImage(backgroundImage, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = shadowImage
        navigationController?.navigationBar.isTranslucent = isTranslucent
        navigationController?.navigationBar.barStyle = barStyle
    }
    
    public func navigationNoLineBar() {
        
        configureNavigationBar(backgroundImage: UIImage(), shadowImage: UIImage())
        
        navigationController?.navigationBar.tintColor = Colour.black
        navigationController?.navigationBar.barTintColor = Colour.background
        navigationController?.navigationBar.backgroundColor = Colour.background
    }
    
    public func navigationLineBar() {
        configureNavigationBar()
        
        navigationController?.navigationBar.tintColor = Colour.black
        navigationController?.navigationBar.barTintColor = Colour.white
        navigationController?.navigationBar.backgroundColor = Colour.white
    }
    
    public func brandNavigationBar() {
        configureNavigationBar(shadowImage: UIImage(), barStyle: .black)
    }
    
    public func clearNavigationBar() {
        configureNavigationBar(isTranslucent: true, backgroundImage: UIImage(), shadowImage: UIImage())
        
        navigationController?.navigationBar.tintColor = Colour.black
        navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
    
    public func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}
