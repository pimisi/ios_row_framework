//
//  SiteMap.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/14.
//  Copyright © 2020 Paul Imisi. All rights reserved.
//

import Foundation

struct SiteMap: Codable {
    let request: Request?
    let variables: Variables?
    let sitemap: [Sitemap?]
    
    enum CodingKeys: String, CodingKey {
        case request, sitemap, variables
    }
}

struct Sitemap: Codable {
    let A, APPCOPY, C, DMC, M, P, PG, PKW, PD, PN, MID, PT, T, RE: String?
    let FN, SM, SN, TN : Bool?
    let N: Navigation?
    let CH: [Sitemap?]
    let MA: MobileApplication?
    
    enum CodingKeys: String, CodingKey {
        case A, APPCOPY, C, DMC, M, MID, P, PG, PKW, PD, PN, PT, T, RE
        case FN, SM, SN, TN
        case N
        case CH
        case MA
    }
}
