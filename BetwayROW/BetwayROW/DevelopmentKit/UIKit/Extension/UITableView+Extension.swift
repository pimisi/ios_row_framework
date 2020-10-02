//
//  UITableView+Extension.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/28.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

@IBDesignable
extension UITableView {
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let uiColor = newValue else { return }
            bordered(width: borderWidth, color: uiColor)
        }
        
    }
    @IBInspectable
    var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { bordered(width: newValue, color: borderColor) }
    }
    
    @IBInspectable
    var cornerRadius:CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
}
