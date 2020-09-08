//
//  Constant.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/08.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

public class ConstantType {
    fileprivate init() {}
}

public class Constant: ConstantType {
    static let infoDictionary = Bundle.main.infoDictionary
    
    static var appVersionString: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
}
