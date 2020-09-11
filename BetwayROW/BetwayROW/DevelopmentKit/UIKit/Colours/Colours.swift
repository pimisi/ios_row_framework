//
//  Colours.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/11.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

final class Colours {

    public static let shared = Colours()
    
    // MARK: Colours
    var primary: UIColor { UIColor(named: "primary") ?? UIColor()}
    var secondary: UIColor { UIColor(named: "secondary") ?? UIColor() }

    // MARK: Black & White
    var white: UIColor { UIColor(named: "white") ?? .white }
    var background: UIColor { UIColor(named: "background") ?? UIColor() }
    var lightGrey: UIColor { UIColor(named: "lightGrey") ?? UIColor() }
    var grey: UIColor { UIColor(named: "grey") ?? UIColor() }
    var mediumGrey: UIColor { UIColor(named: "mediumGrey") ?? UIColor() }
    var darkGrey: UIColor { UIColor(named: "darkGrey") ?? UIColor() }
    var dark: UIColor { UIColor(named: "dark") ?? UIColor() }
    var black: UIColor { UIColor(named: "black") ?? .black }
}
