//
//  APIError.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/09.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

struct APIError: FailureType, Codable {
    let errors: [APIFieldError?]?
    let message: String?
    let code: Int
    
    var value: Int { return code }
    
    enum CodingKeys: String, CodingKey {
        case message, code, errors
    }
}
