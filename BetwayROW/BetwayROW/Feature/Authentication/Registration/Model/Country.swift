//
//  Country.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/23.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation

typealias Countries = [Country]

struct Country: Codable {
    let name, code, dialingCode: String?
    
    enum CodingKeys: String, CodingKey {
        case name, code, dialingCode
    }
}
