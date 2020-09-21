//
//  Colour.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/11.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

struct Colour {

    private init() {}
    
    private static let `defaultColor` = UIColor()
    
    static let primary = UIColor(named: "primary") ?? `defaultColor`
    static let primaryHover = UIColor(named: "primaryHover") ?? `defaultColor`
    static let secondary = UIColor(named: "secondary") ?? `defaultColor`
    
    // MARK: - Background
    
    struct Background {
        static let `default` = UIColor(named: "background") ?? `defaultColor`
        static let pale = UIColor.from(hex: "F8F8F8")
    }
    
    // MARK: - White
    
    static let white = UIColor(named: "white") ?? .white
    
    // MARK: - Black
    
    static let dark = UIColor(named: "dark") ?? `defaultColor`
    static let black = UIColor(named: "black") ?? .black
    static let clear = UIColor.clear
    
    // MARK: - Grey
    
    struct Grey {
        static let `default` = UIColor(named: "grey") ?? `defaultColor`
        static let pale = UIColor(named: "f8f")
        static let light = UIColor(named: "lightGrey") ?? `defaultColor`
        static let medium = UIColor(named: "mediumGrey") ?? `defaultColor`
        static let dark =  UIColor(named: "darkGrey") ?? `defaultColor`
        static let dcd = UIColor(named: "dcd") ?? `defaultColor`
    }
    
    static let transparent = UIColor.clear
}
