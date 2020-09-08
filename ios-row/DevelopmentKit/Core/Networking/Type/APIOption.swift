//
//  APIOption.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/08.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

public struct APIOption {
    var httpHeaders: [String: String]?
    var acceptHeader = ["Accept": "application/json"]
    var method: HTTPMethod?
}
