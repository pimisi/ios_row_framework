//
//  AccountConstant.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/10/01.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation

extension Constant {
    
    // swiftlint:disable nesting
    class Account: ConstantType {
        class Component: ConstantType {
            class Button: ConstantType {
                static let login = Localizable.localized(key: "LOGIN")
                static let register = Localizable.localized(key: "REGISTER")
            }
        }
    }
}

extension Constant.Storyboard {
    static let registration = "Registration"
}

extension APIEndpoint {
    class Account: ConstantType {
        static let base = Authentication.base + "Account/"
        static let exists = Authentication.base + "Exist/5"
        static let register = Authentication.base + "Register"
    }
}

extension APIHeaders.Key {
    static let username = "x-username"
}
