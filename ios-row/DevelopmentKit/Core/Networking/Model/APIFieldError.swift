//
//  APIFieldError.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/09.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

struct APIFieldError: Codable {
    let field: String?
    let error: String?
    
    enum CodingKeys : String, CodingKey {
        case field, error
    }
}
