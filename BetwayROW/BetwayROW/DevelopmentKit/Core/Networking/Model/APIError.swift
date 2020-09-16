//
//  APIError.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/09.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

struct APIError: FailureType, Equatable, Codable {

    let message: String?
    let code: Int
    let errors: [APIFieldError?]?
    
    var value: Int { return code }
    
    enum CodingKeys: String, CodingKey {
        case message, code, errors
    }
}
