//
//  Configuration.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

extension APIEndpoint {
    class Configuration: ConstantType {
        static let base = Constant.API.BaseURL.restOfWorld + "Configuration/"
        static let channels = "Channels/"
        static let clientInfo = "ClientInfo"
    }
}
