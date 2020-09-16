//
//  MobileApplication.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation

struct MobileApplication: Codable {
    let content, component : String?
    let enabled: Bool?
    
    enum CodingKeys: String, CodingKey {
        case content, enabled, component
    }
}
