//
//  UsernameValidation.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/29.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation

struct UsernameValidation: Codable {
    let suggestions : [String?]?
    let exists: Bool?
    
    enum CodingKeys: String, CodingKey {
        case exists, suggestions
    }
}
