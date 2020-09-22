//
//  Login.swift
//  BetwayROW
//
//  Created by Gugulethu Mhlanga on 2020/09/22.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

struct Login: Codable {
    var launchTokens,refreshTokens : [String?]?
    let expiresIn: Int?
    let accessToken,refresh: String
    let userToken: String?
    
    enum CodingKeys: String, CodingKey {
        case launchTokens, refreshTokens, accessToken, refresh, expiresIn,userToken
    }
}
