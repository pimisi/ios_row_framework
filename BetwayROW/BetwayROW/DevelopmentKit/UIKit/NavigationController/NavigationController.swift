//
//  NavigationController.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/15.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func navigationNoLineBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = Colour.black
        navigationController?.navigationBar.barTintColor = Colour.background
        navigationController?.navigationBar.backgroundColor = Colour.background
    }
    
    public func navigationLineBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = Colour.black
        navigationController?.navigationBar.barTintColor = Colour.white
        navigationController?.navigationBar.backgroundColor = Colour.white
    }
    
    public func brandNavBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
    }
    
    public func navigationClearBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = Colour.black
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.barStyle = .default
    }
    
    public func hideNavBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}
