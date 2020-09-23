//
//  UITextField+Extension.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/18.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

@IBDesignable
extension UITextField {
    
    @IBInspectable
    var leftPadding: CGFloat {
        get { return leftView?.frame.size.width ?? 0 }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var rightPadding: CGFloat {
        get { return rightView?.frame.size.width ?? 0 }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    
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
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { bordered(width: newValue, color: borderColor) }
    }
    
    @IBInspectable public var cornerRadius:CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
