//
//  Currency.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/23.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation

typealias Currencies = [Currency]

struct Currency: Codable {
    let currencyCode, currencyName, currencyShortName: String?
    
    enum CodingKeys: String, CodingKey {
        case currencyCode, currencyName, currencyShortName
    }
}
