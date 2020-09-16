//
//  GamingSystemsConstant.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

extension APIEndpoint {
    class GamingSystems: ConstantType {
        static let base = Constant.API.BaseURL.gamingSystem
        static let site = "site/get"
    }
}

extension URLParams.Key {
    static let host = "host"
    static let userAgent = "userAgent"
    static let app = "app"
}

extension URLParams.Value {
    static let host = "en.betway.bg"
    static let userAgent = "IOS"
    static let app = "true"
}
