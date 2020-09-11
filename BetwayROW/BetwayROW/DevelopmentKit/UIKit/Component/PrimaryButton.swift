//
//  PrimaryButton.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/11.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable public class PrimaryButton: UIButton {
    
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
    
    public func setupLayout() {
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 2.0
        self.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.bold)
        self.setTitleColor(Colours.shared.white, for: .normal)
        self.backgroundColor = Colours.shared.primary
    }
}
