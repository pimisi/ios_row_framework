//
//  NSLayoutConstraint+Extension.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/11.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

extension NSLayoutConstraint.Attribute {
    
    var isVertical: Bool {
        return [.top, .bottom].contains(self)
    }
    
    var isHorizontal: Bool {
        return [.leading, .trailing].contains(self)
    }
}
