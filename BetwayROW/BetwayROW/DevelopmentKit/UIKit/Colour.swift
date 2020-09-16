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
    
    private static let `default` = UIColor()
    
    // MARK: Colour
    
    static let primary = UIColor(named: "primary") ?? `default`
    static let secondary = UIColor(named: "secondary") ?? `default`

    static let background = UIColor(named: "background") ?? `default`
    
    // MARK: White
    
    static let white = UIColor(named: "white") ?? .white
    
    // MARK: - Black & Grayscale
    
    static let lightGrey = UIColor(named: "lightGrey") ?? `default`
    static let grey = UIColor(named: "grey") ?? `default`
    static let mediumGrey = UIColor(named: "mediumGrey") ?? `default`
    static let darkGrey =  UIColor(named: "darkGrey") ?? `default`
    static let dark = UIColor(named: "dark") ?? `default`
    static let black = UIColor(named: "black") ?? .black
    
    static let transparent = UIColor.white.withAlphaComponent(0.0)
}
