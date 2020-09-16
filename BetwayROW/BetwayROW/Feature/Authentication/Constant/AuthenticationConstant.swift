//
//  AuthenticationConstant.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/16.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation

typealias AuthenticationConstant = Constant.Authentication

extension Constant {
    
    // swiftlint:disable nesting
    class Authentication: ConstantType {
        class Component: ConstantType {
            static let username = Localization.localized(key: "USER_NAME")
            static let password = Localization.localized(key: "PASSWORD")
            static let login = Localization.localized(key: "LOG_IN")
            
            class Button: ConstantType {
                static let login = Localization.localized(key: "LOGIN")
                static let register = Localization.localized(key: "REGISTER")
                static let forgotPassword = Localization.localized(key: "FORGOT_PASSWORD")
            }
        }
    }
}
