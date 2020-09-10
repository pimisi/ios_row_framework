//
//  URLSessionConfiguration+Extension.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/08.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

extension URLSessionConfiguration {
    static var defaultHeaders: StringKeyDictionary {
        return Constant.API.Headers.ContentType.json.merging(Constant.API.Headers.Accept.json) { $1 }
    }
}
