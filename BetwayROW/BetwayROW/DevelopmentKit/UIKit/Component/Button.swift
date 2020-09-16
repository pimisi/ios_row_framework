//
//  Button.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

@IBDesignable
class Button: UIButton {
    
    @IBInspectable
    public var borderColor: UIColor? {
        get {
            guard let borderColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: borderColor)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat = 0 {
        didSet { layer.borderWidth = borderWidth }
    }
    
    @IBInspectable
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    var type: CustomButtonType = .`default`(type: .custom)
    
    init(type: CustomButtonType = .`default`(type: .system), frame: CGRect = .zero) {
        self.type = type
        
        super.init(frame: frame)
        setup()
    }
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    public func setup() {
        
        switch type {
        case .`default`:
            titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        default:
            borderWidth = 2.0
            cornerRadius = 2.0
            
            switch type {
            case .primary:
                setTitleColor(Colour.white, for: .normal)
                backgroundColor = Colour.primary
            case .secondary:
                borderColor = Colour.primary
                titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                setTitleColor(Colour.primary, for: .normal)
                backgroundColor = Colour.white
            default: break
            }
        }
    }
    
}
