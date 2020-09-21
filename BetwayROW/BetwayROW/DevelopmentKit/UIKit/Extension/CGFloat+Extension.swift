//
//  CGFloat+Extension.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/21.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import UIKit

extension CGFloat {
    
    static func from(value: Any?, `default`: CGFloat) -> CGFloat {
        let floatValue: CGFloat
        
        if let valueAsDouble = value as? Double {
            floatValue = CGFloat(valueAsDouble)
        } else if let valueAsInt = value as? Int {
            floatValue = CGFloat(valueAsInt)
        } else {
            floatValue = `default`
        }
        
        return floatValue
    }
    
    static func from(value: Any?, `default`: (() -> CGFloat)) -> CGFloat {
        return from(value: value, default: `default`())
    }
}
