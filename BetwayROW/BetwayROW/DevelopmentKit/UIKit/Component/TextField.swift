//
//  InputTextFields.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/11.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class TextField: UITextField {
    
    var type: TextFieldType = .generic
    
    init(type: TextFieldType = .generic, frame: CGRect = .zero) {
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
    
    override open func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 15, dy: 0)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 15, dy: 0)
    }
    
    public func setup() {
        borderStyle = .none
        font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        textColor = Colour.dark
        layer.borderColor = Colour.lightGrey.cgColor
        layer.borderWidth = 1.0
        backgroundColor = Colour.white
        
        if let placeholderText: String = placeholder {
            self.attributedPlaceholder =  NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: Colour.grey])
        }
        
        switch type {
        case .password: isSecureTextEntry = true
        default: break
        }
    }
}
