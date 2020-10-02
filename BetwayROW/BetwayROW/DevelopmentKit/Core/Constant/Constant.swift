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
    
    class Defaults {
        static let appOpenCount = "appOpenCount"
    }
}

extension Constant {
    class Component: ConstantType {
        static let identificationList = [
            "Boat License",
            "Credencialde Elector",
            "CPF",
            "CPR",
            "CURP",
            "DNI",
            "Drivers License Number",
            "Gun Licence",
            "Identity Card",
            "Identity Card Number",
            "Identity Certificate Number",
            "Identity Document",
            "Military Id",
            "National RN Number",
            "Nat Reg Number",
            "NIE",
            "Other",
            "PAN",
            "Passport",
            "Passport Registry Number",
            "Pension Book",
            "Personal Identification Number",
            "Personal ID Card BT Model",
            "Personal ID Card AT Model",
            "Registro Federalde Contribuyentes",
            "Residence Permit",
            "Social Security Card",
            "Swedish Personal Id",
            "Thermal Plant Permit",
            "Travel Document",
            "Unknown"
        ]
    }
}
