//
//  APIClient.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/08.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

class APIClient: APIClientProtocol {
    var options = APIOption()
    
    var defaultHeaders: HashableKeyDictionary {
        return Constant.API.Headers.ContentType.json
    }
    
    static func client(withURL url: String) -> APIClientProtocol? {
        return nil
    }
}
