//
//  Configuration.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation

struct Configuration: Codable {
    let android: Int?
    let ios: Int?
    let webdesktop: Int?
    let webmobile: Int?
    
    enum CodingKeys: String, CodingKey {
        case android, ios, webdesktop, webmobile
    }
}
