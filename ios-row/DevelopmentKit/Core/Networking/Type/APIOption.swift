//
//  APIOption.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/08.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

public struct APIOption {
    var method: HTTPMethod?
    var httpHeaders: GenericDictionary?
    var acceptHeader = Constant.API.Headers.Accept.json
    var expectedStatusCode: Int?
    var requestTimeout: TimeInterval? = 150.0
}
