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
    var httpHeaders: StringKeyDictionary?
    var acceptHeader = Constant.API.Headers.Accept.json
    var authorizationType: APIHeaders.AuthorizationType = .bearer
    var authorizationValue: String?
    var expectedStatusCode: Int?
    var minimumAcceptanceSuccessStatusCode = 300
    var requestTimeout: TimeInterval? = 150.0
}
