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

typealias ApplicationConstant = Constant.Application

// swiftlint:disable nesting
public class Constant: ConstantType {
    static let infoDictionary = Bundle.main.infoDictionary
    static let bundle = Bundle(for: Constant.self)
    
    class BundleKey: ConstantType {}
    
    class Application: ConstantType {
        static var versionString: String? {
            return infoDictionary?["CFBundleShortVersionString"] as? String
        }
        
        class Data: ConstantType {
            class Key: ConstantType {
                static let productID = "ProductID"
            }
        }
    }
    
    class Storyboard: ConstantType {}
}
