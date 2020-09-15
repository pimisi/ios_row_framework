//
//  SecondaryButton.swift
//  BetwayROW
//
//  Created by user on 2020/09/14.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation
import UIKit

public class SecondaryButton: UIButton {
    
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
        self.layer.borderColor = Colours.shared.primary.cgColor
        self.layer.borderWidth = 1.0
        self.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        self.setTitleColor(Colours.shared.primary, for: .normal)
        self.backgroundColor = Colours.shared.white
    }
}
