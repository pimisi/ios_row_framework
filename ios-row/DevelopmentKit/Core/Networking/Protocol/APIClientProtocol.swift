//
//  APIClientProtocol.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/08.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

protocol APIClientProtocol {
    var options: APIOption { get }
    var defaultHeaders: HashableKeyDictionary { get }
    
    static func client(withURL url: String) -> APIClientProtocol?
}
