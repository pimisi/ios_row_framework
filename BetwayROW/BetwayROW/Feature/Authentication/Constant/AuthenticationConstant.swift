//
//  AuthenticationConstant.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/16.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

typealias AuthenticationConstant = Constant.Authentication

extension Constant {
    
    // swiftlint:disable nesting
    class Authentication: ConstantType {
        class Component: ConstantType {
            static let username = Localizable.localized(key: "USER_NAME")
            static let password = Localizable.localized(key: "PASSWORD")
            static let login = Localizable.localized(key: "LOG_IN")
            
            class Button: ConstantType {
                static let login = Localizable.localized(key: "LOGIN")
                static let register = Localizable.localized(key: "REGISTER")
                static let forgotPassword = Localizable.localized(key: "FORGOT_PASSWORD")
            }
        }
    }
}

extension APIEndpoint {
    
    class Authentication: ConstantType {
        static let base = Constant.API.BaseURL.restOfWorld + "Authentication/"
        class Login: ConstantType {
            static let base = Authentication.base + "Login/10"
        }
    }
}

extension ApplicationConstant.Data.Key {
    static let userLoggedIn = "UserLoggedIn"
}
