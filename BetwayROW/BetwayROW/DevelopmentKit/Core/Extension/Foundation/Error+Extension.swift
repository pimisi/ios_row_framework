//
//  Error+Extension.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/09.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

extension Error {

    private var this: NSError {
        return self as NSError
    }

    var code: Int {
        return this.code
    }

    var domain: String {
        return this.domain
    }

    var userInfo: [String: Any] {
        return this.userInfo
    }

    var description: String {
        return (userInfo[NSLocalizedDescriptionKey] as? String) ?? String()
    }
}
