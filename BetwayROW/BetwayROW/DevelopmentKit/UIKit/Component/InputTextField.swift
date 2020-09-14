//
//  InputTextFields.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/11.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class BrandTextField: UITextField {
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupLayout()
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
    
    public func setupLayout() {
        self.borderStyle = .none
        self.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        self.textColor = Colours.shared.dark
        self.layer.borderColor = Colours.shared.grey.cgColor
        self.layer.borderWidth = 1.0
        self.backgroundColor = Colours.shared.white
        guard let placeholderText: String = self.placeholder else {
            return
        }
        self.attributedPlaceholder =  NSAttributedString(string: placeholderText,
                                                         attributes: [NSAttributedString.Key.foregroundColor: Colours.shared.grey])
    }
}
