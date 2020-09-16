//
//  Variables.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

struct Variables: Codable {
    let cms: String?
    let cdn: String?
    let apic: String?
    let api: String?
    
    enum CodingKeys: String, CodingKey {
        case cms, cdn, apic, api
    }
}
