//
//  Navigation.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

struct Navigation: Codable {
    let top, footer, left: Bool?
    
    enum CodingKeys: String, CodingKey {
        case top, footer, left
    }
}
