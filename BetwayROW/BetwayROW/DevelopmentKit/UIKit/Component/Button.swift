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
    
    enum CustomType {
        case primary, secondary, `default`(type: UIButton.ButtonType)
    }

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
    
    var type: CustomType = .`default`(type: .custom)
    
    init(type: CustomType = .`default`(type: .system), frame: CGRect = .zero) {
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
        
        if self.frame == .zero {
            var frame = self.frame
            frame.size.height = 40
            self.frame = frame
        }
        
        switch type {
        case .`default`:
            titleLabel?.font = UIFont(name: "Arial", size: 12)
        default:
            cornerRadius = 2.0
            
            switch type {
            case .primary:
                backgroundColor = Colour.primary
                setTitleColor(Colour.white, for: .normal)
                titleLabel?.font = UIFont(name: "Arial", size: 12)?.bold()
                setBackgroundImage(UIImage.from(color: Colour.primaryHover), for: .highlighted)
                setBackgroundImage(UIImage.from(color: Colour.primary.withAlphaComponent(0.4)), for: .disabled)
            case .secondary:
                borderWidth = 1.0
                borderColor = Colour.primary
                titleLabel?.font = UIFont(name: "Arial", size: 12)
                backgroundColor = Colour.white
                setTitleColor(Colour.primary, for: .normal)
                setTitleColor(Colour.white, for: .highlighted)
                setBackgroundImage(UIImage.from(color: Colour.primary), for: .highlighted)
            default: break
            }
        }
    }
}

extension UIFont {

    func withTraits(traits:UIFontDescriptor.SymbolicTraits...) -> UIFont {
        if let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits)) {
            return UIFont(descriptor: descriptor, size: 0)
        }
        return UIFont()
    }

    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
}
