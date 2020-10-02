//
//  Nationality.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/23.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation

typealias Nationalities = [Nationality]

struct Nationality: Codable {
    let name, code: String
    
    enum CodingKeys: String, CodingKey {
        case name, code
    }
}
