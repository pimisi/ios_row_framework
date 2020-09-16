//
//  Request.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

struct Request: Codable {
    let culture: String?
    let host: String?
    
    enum CodingKeys: String, CodingKey {
        case culture, host
    }
}
